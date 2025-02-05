//
//  Headers.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

public class Headers {
    public static let xtime = "X-Time"
    public static let xdeviceToken = "X-DeviceToken"
    public static let authorization = "Authorization"

    static public func defaultHTTPHeaders() -> [String: String] {
        var headers = [String: String]()
        let dateString = AppConfiguration.sharedInstance.getDateString(from: Date())

        headers.setValue(value: dateString, forKeyPath: xtime)

        return headers
    }

    static public func defaultAuthorizationHeader(with token: String) -> String {
        Constants.authorisationPrefix + token
    }

    // MARK: Constants

    private enum Constants {
        static let targetChar = "-"
        static let replacementChar = ""
        static let authorisationPrefix = "Bearer "
    }
}
