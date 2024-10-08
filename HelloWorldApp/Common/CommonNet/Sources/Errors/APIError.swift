//
//  APIError.swift
//  CommonNet
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

extension ErrorResponseMo: Error {}
extension AbstractPollingResponseMo: Error {}

public struct ResponseInfo {

    // MARK: Properties

    public let url: URL?
    public let headers: [AnyHashable: Any]?

    // MARK: Methods

    public init(with response: URLResponse?) {
        self.url = response?.url
        self.headers = (response as? HTTPURLResponse)?.allHeaderFields
    }

    public func traceID() -> String? {
        let value = headers?[Constants.traceId] as? String
        return value
    }
}

extension Error {
    public func getTopLayerErrorResponse() -> ErrorResponseMo? {
        guard let self = self as? ApiError else {
            return nil
        }

        if case let ApiError.topLayerError(reason) = self,
           case let TopErrorReason.business(error) = reason {
            return error as? ErrorResponseMo
        }
        return nil
    }
}

public enum ApiError: Error {
    case topLayerError(TopErrorReason)
    case applicationLayerError(ApplicationErrorReason, responseInfo: ResponseInfo?)
    case transportLayerError(TransportErrorReason)
    case prepareLayerError(Error)
}

protocol ErrorProtocol {
    func errorResponse() -> ErrorResponseMo?
}

public enum TopErrorReason: Error {
    case business(error: Error)
}

extension TopErrorReason: ErrorProtocol {
    public func errorResponse() -> ErrorResponseMo? {
        switch self {

        case .business(error: let error):
            return error as? ErrorResponseMo
        }
    }
}

public enum TransportErrorReason: Error {
    case connection
    case notAvailableServer(Int?, URL?)
}

public enum ApplicationErrorReason: Error {
    case response(statusCode: HttpCode, error: Error?)
    case conversion(reason: String? = nil, data: Any? = nil, error: Error? = nil)
    case timeout(error: Error)
    case unknownError(statusCode: Int?, error: Error?)
}

extension ApplicationErrorReason: ErrorProtocol {
    public func errorResponse() -> ErrorResponseMo? {
        switch self {
        case .response(_, error: let error):
            return error as? ErrorResponseMo

        case .conversion:
            return nil

        case .timeout:
            return nil

        case .unknownError:
            return nil
        }
    }
}

extension ErrorResponseMo {
    public func convertToApiError() -> ApiError {
        ApiError.topLayerError(.business(error: self))
    }
}

fileprivate enum Constants {
    static let traceId: String = "Trace-Id"
}

public enum ErrorDetailFieldCodes: String {
    case password
}
