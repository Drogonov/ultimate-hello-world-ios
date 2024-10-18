//
//  File.swift
//  DI
//
//  Created by Anton Vlezko on 12/03/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

/// https://github.com/apple/swift-evolution/blob/master/proposals/0258-property-wrappers.md#delayed-initialization
@propertyWrapper
public struct DelayedImmutable<Value> {
    private var _value: Value?

    public init() {
        _value = nil
    }

    public var wrappedValue: Value {
        get {
            guard let value = _value else {
                fatalError("property accessed before being initialized")
            }
            return value
        }

        // Perform an initialization, trapping if the
        // value is already initialized.
        set {
            if _value != nil {
                fatalError("property initialized twice")
            }
            _value = newValue
        }
    }

    public var isInitialized: Bool {
        _value != nil
    }
}
