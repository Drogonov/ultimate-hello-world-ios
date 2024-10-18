//
//  NetHeaders.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Common

public struct NetHeaders {
    public init(dict: [String: String] = [:]) {
        dictOfHeaders = dict
    }

    var dictOfHeaders: [String: String]

    public func jsonContentTypeHeader() -> Self {
        return modify(key: "Content-Type", value: "application/json; charset=utf-8")
    }

    public func modify(key: String, value: String) -> Self {
        var currentCopy = self
        currentCopy.dictOfHeaders[key] = value
        return currentCopy
    }

    public func append(dict: [String: String]) -> Self {
        var currentCopy = self
        currentCopy.dictOfHeaders += dict
        return currentCopy
    }
}

public extension NetHeaders {

    static func defaultHeaders() -> Self {
        let dateString = AppConfiguration.sharedInstance.getDateString(from: Date())

        var headers = NetHeaders()
            .modify(key: Headers.xtime, value: dateString)

        headers = appendAutoTestHeader(headers)
        return headers
    }

    private static func appendAutoTestHeader(_ headers: NetHeaders) -> NetHeaders {
        return headers
    }
}
