//
//  NetRequestProtocol.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Common

public protocol NetRequestProtocol {
    associatedtype RequestBody

    var method: NetMethod { get }
    var stringUrl: String? { get }
    var headers: NetHeaders { get set }
    var paramsEncoder: NetEncoderProtocol { get }
    var params: RequestBody? { get }
    var timeout: NetTimeoutProtocol { get }
    var urlPath: String { get }
}

extension NetRequestProtocol {

    func createRequest(
            with defaultHeaders: NetHeaders = NetHeaders(),
            baseUrlString: String = "",
            cookies: [HTTPCookie] = []
    ) throws -> URLRequest? {
        let newUrlString = extractUrl(baseUrlString: baseUrlString)
        guard let url = URL(string: newUrlString) else {
            return nil
        }

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers.dictOfHeaders + defaultHeaders.dictOfHeaders
        request.httpMethod = method.rawValue
        try paramsEncoder.encode(params, request: &request)
        request.httpShouldHandleCookies = true

        guard !cookies.isEmpty else {
            return request
        }

        let cookiesDict = HTTPCookie.requestHeaderFields(with: cookies)
        request.allHTTPHeaderFields = (request.allHTTPHeaderFields ?? [:]) + cookiesDict

        return request
    }

    func createSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeout.timeInterval()

        return URLSession(configuration: configuration)
    }

    private func extractUrl(baseUrlString: String) -> String {
        if let stringUrl = stringUrl, !stringUrl.isEmpty {
            return stringUrl
        }

        return baseUrlString.appending(urlPath)
    }
}
