//
//  ConfigurationProvider.swift
//  CommonNet
//
//  Created by Anton Vlezko on 16/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation

// MARK: - ConfigurationProviderProtocol

public protocol ConfigurationProviderProtocol {
    var defaultBaseURL: String { get }
}

// MARK: - ConfigurationProvider

public class ConfigurationProvider: ConfigurationProviderProtocol {
    public var defaultBaseURL: String {
        guard let url = Bundle.main.object(forInfoDictionaryKey: Constants.baseURLDevKey) as? String else {
            fatalError("BaseURL must be set in plist")
        }
        return url
    }
}

// MARK: - Constants

fileprivate extension ConfigurationProvider {
    enum Constants {
        static let baseURLDevKey = "BaseURLDev"
    }
}
