//
//  BaseUrlService.swift
//  CommonNet
//
//  Created by Anton Vlezko on 30/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Common

public protocol BaseURLServiceProtocol {
    var baseURL: String? { get }

    func setBaseURLValue(_ value: String)
    func resetDefaultBaseURL()
}

// MARK: - BaseURLService

public class BaseURLService {

    // MARK: Public properties

    public private(set) var baseURL: String?

    // MARK: Private properties

    private let userDefaults: UserDefaults = .standard
    private let configurationProvider: ConfigurationProviderProtocol = ConfigurationProvider()

    // MARK: Init

    public init() {
        getBaseURL()
    }
}

// MARK: - BaseURLServiceProtocol

extension BaseURLService: BaseURLServiceProtocol {
    public func setBaseURLValue(_ value: String) {
        guard URL(string: value) != nil else {
            return
        }

        userDefaults.set(value, forKey: Constants.baseURLKey)
        baseURL = value
    }

    public func resetDefaultBaseURL() {
        baseURL = configurationProvider.defaultBaseURL
        userDefaults.set(baseURL, forKey: Constants.baseURLKey)
    }
}

// MARK: - Private Methods

private extension BaseURLService {
    func getBaseURL() {
        if let savedURL = userDefaults.string(forKey: Constants.baseURLKey) {
            baseURL = savedURL
        } else {
            baseURL = configurationProvider.defaultBaseURL
        }
    }
}

// MARK: - Constants

fileprivate extension BaseURLService {
    enum Constants {
        static let baseURLKey = "baseURLKey"
    }
}
