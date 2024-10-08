//
//  RepeaterProtocol.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

// sourcery: AutoMockable
public protocol RepeaterProtocol {
    func checkForRepeatAndWaitIfNeeded(error: Error) async throws -> Bool
}

extension RepeaterProtocol {
    public func checkForRepeatAndWaitIfNeeded(error: Error) async throws -> Bool {
        false
    }
}

