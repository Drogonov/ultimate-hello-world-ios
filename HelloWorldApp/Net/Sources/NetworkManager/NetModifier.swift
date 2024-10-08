//
//  ACModifier.swift
//  Net
//
//  Created by Anton Vlezko on 30/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import DI
import Common
import CommonNet

// MARK: - NetModifier

final public class NetModifier {

    // MARK: Public Properties

    @DelayedImmutable public var appConfiguration: AppConfigurationProtocol

    // MARK: Init

    public init() {}
}

// MARK: - NetModifierProtocol

extension NetModifier: NetModifierProtocol {

    func provideCookies<Request>(for request: Request) -> [HTTPCookie] where Request: NetRequestProtocol {
        return []
    }

    public func modify(request: URLRequest) -> URLRequest {
        var mutatingRequest = request
        addDefaultHeaders(to: &mutatingRequest)
        return mutatingRequest
    }

    public func modify(data: Data, response: URLResponse) -> Data {
        guard let response = response as? HTTPURLResponse else {
            return data
        }
        var modifiedData: Data? = nil

        var json = try? JSONSerialization.jsonObject(with: data, options: [])
        addServerTime(to: &json, from: response)

        guard let json = json else {
            return data
        }

        modifiedData = try? JSONSerialization.dataExt(withJSONObject: json, options: .prettyPrinted)

        guard let modifiedData = modifiedData else {
            return data
        }

        return modifiedData
    }

    public func responseProvided(request: URLRequest, response: URLResponse?, data: Data?, error: Error?) {
        // ...
    }

    public func provideBaseUrl<Request: NetRequestProtocol>(for request: Request) -> String {
        BaseUrls.getHost()
    }
}

// MARK: - Private
fileprivate extension NetModifier {

    // MARK: Default headers
    private func addDefaultHeaders(to request: inout URLRequest) {
        let dateString = appConfiguration.getDateString(from: Date())
        request.allHTTPHeaderFields?[Headers.xtime] = dateString
    }

    // MARK: Server Time
    private func addServerTime(to JSON: inout Any?, from response: HTTPURLResponse?) {
        if let serverTime = response?.allHeaderFields["Date"] {
            if var JSONToModify = JSON as? [String: Any] {
                JSONToModify.setValue(value: serverTime, forKeyPath: "_<serverTime>_")
                JSON = JSONToModify
            } else if let JSONArrayToModify = JSON as? [[String: Any]] {
                var modifiedJSONArray = [[String: Any]]()
                for element in JSONArrayToModify {
                    var elementToModify = element
                    elementToModify.setValue(value: serverTime, forKeyPath: "_<serverTime>_")
                    modifiedJSONArray.append(elementToModify)
                }
                JSON = modifiedJSONArray
            }
        }
    }
}

