//
//  NetModifierProtocol.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

public protocol NetModifierProtocol: AnyObject {
    func modify(request: URLRequest) -> URLRequest
    func modify(data: Data, response: URLResponse) -> Data
    func responseProvided(request: URLRequest, response: URLResponse?, data: Data?, error: Error?)
    func provideBaseUrl<Request: NetRequestProtocol>(for request: Request) -> String
    func receivedCookies<Request: NetRequestProtocol>(for request: Request, cookies: [HTTPCookie])
}

public extension NetModifierProtocol {
    func modify(request: URLRequest) -> URLRequest {
        request
    }

    func provideBaseUrl<Request: NetRequestProtocol>(for request: Request) -> String {
        return ""
    }

    func provideCookies<Request: NetRequestProtocol>(for request: Request) -> [HTTPCookie]? {
        return []
    }

    func receivedCookies<Request: NetRequestProtocol>(for request: Request, cookies: [HTTPCookie]) {}
}
