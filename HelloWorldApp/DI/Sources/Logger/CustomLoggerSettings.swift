//
//  CustomLoggerSettings.swift
//  DI
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

enum CustomLoggerSettings {
    case network
    case navigation
    case ui
    case message
    case error
    case custom

    var value: String {
        switch self {
        case .network:
            return Constants.network

        case .navigation:
            return Constants.navigation

        case .ui:
            return Constants.ui

        case .message:
            return Constants.message

        case .error:
            return Constants.error

        case .custom:
            return Constants.custom
        }
    }

    func enable(with configuration: CustomLoggerConfiguration) -> Bool {
        switch self {
        case .network:
            return configuration.network

        case .navigation:
            return configuration.navigation

        case .ui:
            return configuration.ui

        case .message:
            return configuration.message

        case .error:
            return true

        case .custom:
            return configuration.custom
        }
    }
}

fileprivate extension CustomLoggerSettings {
    enum Constants {
        static let network: String = "NetworkLog"
        static let navigation: String = "NavigationLog"
        static let ui: String = "UILog"
        static let message: String = "MessageLog"
        static let error: String = "ErrorLog"
        static let custom: String = ""
    }
}
