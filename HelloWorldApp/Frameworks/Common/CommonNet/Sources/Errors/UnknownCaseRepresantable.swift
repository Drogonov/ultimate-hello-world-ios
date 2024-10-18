//
//  UnknownCaseRepresantable.swift
//  CommonNet
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import DI

public protocol UnknownCaseRepresantable: RawRepresentable, CaseIterable where RawValue: Equatable {
    static var unknownCase: Self { get }
}

public extension UnknownCaseRepresantable {

    init(mandatory value: Self.RawValue) {
        if let resultCase = Self(rawValue: value) {
            self = resultCase
        } else {
            CustomLogger.error.log("\(Self.self) -> Can't find case \(String(describing: value))", type: .error)
            self = Self.unknownCase
        }
    }

    init?(optional value: Self.RawValue?) {
        guard let value = value else {
            return nil
        }

        guard let resultCase = Self(rawValue: value) else {
            CustomLogger.error.log("\(Self.self) -> Can't find case \(String(describing: value))", type: .error)
            return nil
        }
        self = resultCase
    }
}
