//
//  BaseUrlService.swift
//  CommonNet
//
//  Created by Anton Vlezko on 30/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Common

// MARK: - BaseURLService

public class BaseURLService: BaseURLServiceProtocol {

    // MARK: Public properties

    public private(set) var baseURL: String?

    // MARK: Private properties

    private let userDefaults: UserDefaults = .standard

    // MARK: Init

    public init() {
        getBaseURL()
    }

    // MARK: Public Methods

    public func setBaseURLValue(_ value: String) {
        userDefaults.set(value, forKey: Constants.baseURLKey)
    }

    public func resetDefaultBaseURL() {
        // Not used.
    }
}

// MARK: - Private Methods

private extension BaseURLService {

    func getBaseURL() {
        if userDefaults.object(forKey: Constants.baseURLKey).isNone {
            baseURL = Constants.defaultBaseURL
        } else {
            baseURL = userDefaults.object(forKey: Constants.baseURLKey) as? String
        }
    }
}

// MARK: - Constants

fileprivate extension BaseURLService {

    // TODO: Fix BaseURL service so it will be working normally not like this hardcodded shit
    enum Constants {
        static let baseURLKey = "baseURLKey"
        static let defaultBaseURL = "http://localhost:6868"
    }
}
