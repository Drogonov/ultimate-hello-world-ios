//
//  LogWriterProtocol.swift
//  DI
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import OSLog

public protocol LogWriterProtocol {
    func log(_ message: String, type: CustomLogType)
    func log(_ messages: [String], type: CustomLogType)
    func log(_ messages: [String], type: CustomLogType, columns: Int)
}

fileprivate extension LogWriterProtocol {

    func trimLongMessage(_ message: String) -> String {
        guard message.count < Constants.maxSymbolsCount else {
            let resultMessage = "\(Constants.prefix) \(String(message.prefix(Constants.prefixSymbolsCount)))"
            debugPrint(message)
            return resultMessage
        }
        return message
    }
}

struct LoggerWriter: LogWriterProtocol {
    let category: String
    let logger: Logger

    init(category: String) {
        self.category = category
        self.logger = Logger(
            subsystem: Bundle.main.bundleIdentifier ?? "",
            category: String(describing: category)
        )
    }

    func log(_ message: String, type: CustomLogType) {
        let resultMessage = trimLongMessage(message)
        let osType = convert(type)
        logger.log(
            level: osType,
            "\(resultMessage)"
        )
    }

    func log(_ messages: [String], type: CustomLogType) {
        log(messages, type: type, columns: 10)
    }

    func log(_ messages: [String], type: CustomLogType, columns: Int) {

        let osType = convert(type)
        switch messages.count {
        case 0:
            break

        case 1:
            logger.log(
                level: osType,
                "\(messages[0])"
            )

        case 2:
            logger.log(
                level: osType,
                "\(messages[0], align: .left(columns: columns))\(messages[1], align: .left(columns: columns))"
            )

        default:
            logger.log(
                level: osType,
                "\(messages[0], align: .left(columns: columns))\(messages[1], align: .left(columns: columns))\(messages[2], align: .left(columns: columns))"
                )
        }
    }

    private func convert(_ type: CustomLogType) -> OSLogType {
        switch type {

        case .debug:
            return OSLogType.default

        case .warning:
            return OSLogType.error

        case .error:
            return OSLogType.fault
        }
    }
}

fileprivate enum Constants {
    static let maxSymbolsCount: Int = 32_768
    static let prefixSymbolsCount: Int = 150
    static let prefix: String = "LONG MESSAGE"
}
