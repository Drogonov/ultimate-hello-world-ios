//
//  NetworkManagerProtocol.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import CommonNet

public protocol NetworkManagerProtocol {

    func makeRequest<RequestResponse: NetRequestResponseProtocol>(
        request: RequestResponse
    ) async throws -> RequestResponse.ParsedModel
}

// MARK: NetworkManager class

public class NetworkManager: NetworkManagerProtocol {

    public init(
        baseUrlString: String = "",
        defaultHeaders: NetHeaders = NetHeaders()
    ) {
        self.baseUrlString = baseUrlString
        self.defaultHeaders = defaultHeaders
    }

    // MARK: NetworkManager errors
    public enum NetworkErrors: Error {
        case nilUrl
    }

    // MARK: public properties
    public var defaultHeaders: NetHeaders
    public var modifier: NetModifierProtocol?
    public var logger: NetLoggerProtocol?

    public var baseUrlString: String = ""

    // MARK: Public methods

    @available(iOS 13, macOS 12, *)
    public func makeRequest<RequestResponse: NetRequestResponseProtocol>(
        request: RequestResponse
    ) async throws -> RequestResponse.ParsedModel {
        var response: (data: Data, response: URLResponse, urlRequest: URLRequest)?
        var responseError: Error?

        do {
            response = try await requestInterceptor(request: request)
            if let response = response {
                logger?.log(request: response.urlRequest, loadedData: response.data, response: response.response)
            }
        } catch {
            responseError = error
        }

        // if we catch first time unauthorized error we will try to refresh tokens and call previous request one more time
        if let urlResponse = response?.response as? HTTPURLResponse,
           urlResponse.statusCode == 401 {
            let wasRefreshed = await tryToRefreshTokens()
            if wasRefreshed {
                response = try? await requestInterceptor(request: request)
                if let response = response {
                    logger?.log(request: response.urlRequest, loadedData: response.data, response: response.response)
                }
            }
        }

        return try request.serializer.serialize(
            requestData: response?.data,
            response: response?.response,
            error: responseError,
            request: request
        )
    }

    @available(iOS 13, macOS 12, *)
    private func requestInterceptor<Request: NetRequestProtocol>(
        request: Request
    ) async throws -> (Data, URLResponse, URLRequest) {
        do {
            var infoFromRequest = try await loadData(request: request)

            guard let modifier = modifier else {
                return infoFromRequest
            }
            infoFromRequest.0 = modifier.modify(data: infoFromRequest.0, response: infoFromRequest.1)
            return infoFromRequest
        } catch {
            throw error
        }
    }

    // MARK: Private methods

    @available(iOS 13, macOS 12, *)
    private func loadData<Request: NetRequestProtocol>(
        request: Request
    ) async throws -> (Data, URLResponse, URLRequest) {
        let baseUrl = baseUrlString.isEmpty ? modifier?.provideBaseUrl(for: request) : baseUrlString
        let cookies = modifier?.provideCookies(for: request) ?? []

        let urlRequest: URLRequest
        do {
            guard
                let createdRequest = try request.createRequest(with: request.headers, baseUrlString: baseUrl ?? "", cookies: cookies)
            else { throw NetworkErrors.nilUrl }
            urlRequest = createdRequest
        } catch {
            throw error
        }

        let session = request.createSession()
        let finalRequest = modifier?.modify(request: urlRequest) ?? urlRequest

        logger?.willSendRequest(request: finalRequest)

        do {

            let (data, response) = try await session.performDataTask(for: finalRequest)
            modifier?.responseProvided(
                request: finalRequest,
                response: response,
                data: data,
                error: nil
            )

            logger?.didReceiveResponse(response: response, data: data, error: nil, request: finalRequest)

            modifier?.receivedCookies(
                for: request,
                cookies: extractCookies(from: response)
            )

            return (data, response, urlRequest)
        } catch {
            modifier?.responseProvided(
                request: finalRequest,
                response: nil,
                data: nil,
                error: error
            )

            logger?.didReceiveResponse(response: nil, data: nil, error: error, request: finalRequest)
            throw error
        }
    }

    private func tryToRefreshTokens() async -> Bool {
        let request = RefreshTokenRequestData()
        var responseError: Error?

        var response: (data: Data, response: URLResponse, urlRequest: URLRequest)?
        response = try? await requestInterceptor(request: request)

        guard let data = try? request.serializer.serialize(
            requestData: response?.data,
            response: response?.response,
            error: responseError,
            request: request
        ) else {
            return false
        }

        if let token = data.accessToken {
            KeychainJWTProvider.shared.save(.accessToken, token)
        }

        if let token = data.refreshToken {
            KeychainJWTProvider.shared.save(.refreshToken, token)
        }

        return true
    }

    private func extractCookies(from response: URLResponse) -> [HTTPCookie] {
        guard
            let httpResponse = response as? HTTPURLResponse,
            let headers = httpResponse.allHeaderFields as? [String: String],
            let url = response.url
        else { return [] }

        return HTTPCookie.cookies(withResponseHeaderFields: headers, for: url)
    }
}



// MARK: - VoidEncoderForMo class

public class VoidEncoderForMo: NetEncoderProtocol {

    //  MARK: Init

    public init() {}

    // MARK: - NTEncoderProtocol implementation

    public func encode<T>(_ value: T, request: inout URLRequest) throws {
    }
}
