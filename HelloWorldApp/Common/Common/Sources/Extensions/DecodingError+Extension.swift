//
//  DecodingError+Extension.swift
//  Common
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

extension DecodingError: CustomStringConvertible {

    // MARK: Properties

    public var description: String {

        let reason: String
        switch self {

        case let .typeMismatch(_, context):
            reason = context.debugDescription

        case let .valueNotFound(_, context):
            reason = context.debugDescription

        case let .keyNotFound(_, context):
            reason = context.debugDescription

        case let .dataCorrupted(context):
            reason = context.debugDescription

        @unknown default:
            reason = String.empty
        }

        return reason
    }
}
