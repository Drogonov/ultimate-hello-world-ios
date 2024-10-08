//
//  NetTimeout.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

public enum NetTimeout: NetTimeoutProtocol {
    case short
    case normal
    case custom(TimeInterval)

    public func timeInterval() -> TimeInterval {
        switch self {
        case .short:
            return 10

        case .normal:
            return 60

        case .custom(let value):
            return value
        }
    }
}
