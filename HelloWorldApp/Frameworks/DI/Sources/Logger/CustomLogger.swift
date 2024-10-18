//
//  CustomLogger.swift
//  DI
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import OSLog

public enum CustomLogType {
    case debug
    case warning
    case error
}

public protocol CustomLoggerProtocol: AnyObject {
    func log(_ message: String)
    func log(_ messages: [String])
    func log(_ messages: [String], columns: Int)
    func log(_ message: String, type: CustomLogType)
    func log(_ messages: [String], type: CustomLogType)
    func log(_ messages: [String], type: CustomLogType, columns: Int)
}

public final class CustomLogger {

    let category: String
    let logger: LogWriterProtocol

    public init(category: String) {
        self.category = category
        logger = LoggerWriter(category: category)
    }
}

extension CustomLogger: CustomLoggerProtocol {

    public func log(_ message: String) {
        log(message, type: .debug)
    }

    public func log(_ messages: [String]) {
        log(messages, type: .debug)
    }

    public func log(_ messages: [String], columns: Int) {
        log(messages, type: .debug, columns: columns)
    }

    public func log(_ message: String, type: CustomLogType) {
        guard isLoggable() else {
            return
        }
        logger.log(message, type: type)
    }

    public func log(_ messages: [String], type: CustomLogType) {
        guard isLoggable() else {
            return
        }
        logger.log(messages, type: type)
    }

    public func log(_ messages: [String], type: CustomLogType, columns: Int) {
        guard isLoggable() else {
            return
        }
        logger.log(messages, type: type, columns: columns)
    }
}

public extension CustomLogger {
    static let network = CustomLogger(category: CustomLoggerSettings.network.value)
    static let navigation = CustomLogger(category: CustomLoggerSettings.navigation.value)
    static let ui = CustomLogger(category: CustomLoggerSettings.ui.value)
    static let message = CustomLogger(category: CustomLoggerSettings.message.value)
    static let error = CustomLogger(category: CustomLoggerSettings.error.value)
}

fileprivate extension CustomLogger {
#if DEBUG
    func isLoggable() -> Bool {

        let configuration = CustomLoggerConfiguration.make()
        if let mandatoryCategory = configuration.mandatoryCategory,
           !mandatoryCategory.isEmpty,
           mandatoryCategory == category {
            return true
        }

        switch category {
        case CustomLoggerSettings.network.value:
            return CustomLoggerSettings.network.enable(with: configuration)

        case CustomLoggerSettings.navigation.value:
            return CustomLoggerSettings.navigation.enable(with: configuration)

        case CustomLoggerSettings.ui.value:
            return CustomLoggerSettings.ui.enable(with: configuration)

        case CustomLoggerSettings.message.value:
            return CustomLoggerSettings.message.enable(with: configuration)

        case CustomLoggerSettings.error.value:
            return true

        default:
            return CustomLoggerSettings.custom.enable(with: configuration)
        }
    }

#else
    func isLoggable() -> Bool {
        return false
    }
#endif
}

