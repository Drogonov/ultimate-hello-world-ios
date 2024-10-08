//
//  CustomLoggerConfiguration.swift
//  DI
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

public struct CustomLoggerConfiguration: Codable {

    public var network: Bool = false {
        didSet {
            saveConfiguration()
        }
    }
    public var navigation: Bool = false {
        didSet {
            saveConfiguration()
        }
    }
    public var ui: Bool = false {
        didSet {
            saveConfiguration()
        }
    }
    public var message: Bool = false {
        didSet {
            saveConfiguration()
        }
    }
    public var custom: Bool = false {
        didSet {
            saveConfiguration()
        }
    }

    init() {}

    public init(network: Bool, navigation: Bool, ui: Bool, message: Bool, custom: Bool) {
        self.network = network
        self.navigation = navigation
        self.ui = ui
        self.message = message
        self.custom = custom
    }

    var mandatoryCategory: String?

    public static func make() -> CustomLoggerConfiguration {

        if let userDefaults = UserDefaults(suiteName: String(describing: Self.self)),
           let data = userDefaults.object(forKey: String(describing: Self.self)) as? Data,
           let result = try? JSONDecoder().decode(Self.self, from: data) {
            return result
        }

        if let path = Bundle.main.path(forResource: Constants.configFileName, ofType: Constants.configFileType),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
           let result = try? JSONDecoder().decode(Self.self, from: data) {
            return result
        }

        return CustomLoggerConfiguration()
    }
}

fileprivate extension CustomLoggerConfiguration {

    func saveConfiguration() {
        guard
            let data = try? JSONEncoder().encode(self),
            let userDefaults = UserDefaults(suiteName: String(describing: Self.self))
        else {
            return
        }

        userDefaults.setValue(data, forKey: String(describing: Self.self))
    }
}

fileprivate extension CustomLoggerConfiguration {
    enum Constants {
        static let configFileName: String = "CustomLoggerConfiguration"
        static let configFileType: String = "json"
    }
}
