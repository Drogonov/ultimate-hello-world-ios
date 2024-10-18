//
//  BaseUrls.swift
//  CommonNet
//
//  Created by Anton Vlezko on 30/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import DI

open class BaseUrls: NSObject {

    public static let sslStoreKey = "sslOn"

    public enum Scheme: String {
        case http
        case https
    }

    public enum Environment: String, CaseIterable {
        case production

        public static var allCases: [Environment] {
            return [.production]
        }

        public var scheme: String {
            return Scheme.https.rawValue
        }
    }

    @objc
    open class func getHost() -> String {
        var baseURLService: BaseURLServiceProtocol?
        baseURLService = resolveDependency()
        let baseURL = baseURLService?.baseURL ?? ""
        return baseURL
    }

    @objc
    public class func getScheme() -> String {
        var scheme: String!
        let store = UserDefaults.standard
        if let storedScheme = store.string(forKey: BaseUrls.sslStoreKey) {
            scheme = storedScheme
        } else {
            let environment = BaseUrls.checkEnvironment()
            scheme = environment.scheme
        }

        return scheme
    }

    public class func checkEnvironment() -> Environment {
        return Environment.production
    }
}
