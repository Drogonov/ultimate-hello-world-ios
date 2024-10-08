//
//  NetEncoderProtocol.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Common

public protocol NetEncoderProtocol {

    func encode<T>(
            _ value: T,
            request: inout URLRequest
    ) throws
}

extension JSONEncoder: NetEncoderProtocol {

    /// EncodingError. https://developer.apple.com/documentation/swift/encodingerror
    public func encode<T>(_ value: T, request: inout URLRequest) throws {

        request.allHTTPHeaderFields = (request.allHTTPHeaderFields ?? [:]) + NetHeaders().jsonContentTypeHeader().dictOfHeaders
        let wrappedModel = AnyEncodable(value)

        request.httpBody = try self.encode(wrappedModel)
    }
}
