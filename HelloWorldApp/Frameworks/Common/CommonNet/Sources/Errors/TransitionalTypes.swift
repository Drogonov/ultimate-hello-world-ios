//
//  TransitionalTypes.swift
//  CommonNet
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

public protocol StringifiedCode: ExpressibleByStringLiteral {
    func isNone(of statusCodes: Self...) -> Bool
    func isOne(of statusCodes: Self...) -> Bool
}

extension StringifiedCode where Self: Equatable {
    public func isNone(of dataCodes: Self...) -> Bool {
        return !dataCodes.contains(self)
    }

    public func isOne(of dataCodes: Self...) -> Bool {
        return dataCodes.contains(self)
    }
}

public enum Condition { case one, none }

public protocol BusinessLogicCode {
    func would(be condition: Condition, of statusCodes: Self...) -> Bool
}

extension BusinessLogicCode where Self: Equatable {

    public func would(be condition: Condition, of statusCodes: Self...) -> Bool {
        switch condition {
        case .one:
            return statusCodes.contains(self)

        case .none:
            return !statusCodes.contains(self)
        }
    }
}

public enum ServiceStatusCode: ExpressibleByStringLiteral, BusinessLogicCode, StringifiedCode {
    case active, inactive, tempInactive, issue, after, incorrect

    public init(stringLiteral value: String) {
        switch value {
        case "ACTIVE":
            self = .active
        case "INACTIVE":
            self = .inactive
        case "TEMP_INACTIVE":
            self = .tempInactive
        case "ISSUED":
            self = .issue
        case "AFTER":
            self = .after

        default:
            self = .incorrect
        }
    }
}

