//
//  OptionalWrapper.swift
//  Common
//
//  Created by Anton Vlezko on 27/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

public protocol OptionalWrapper {

    // MARK: Properties

    var wrappedType: Any.Type { get }
}

extension Optional: OptionalWrapper {

    // MARK: Properties

    /// Checks if an object is `nil`.
    public var isNone: Bool {
        return self == nil
    }

    /// Returns type wrapped by an `Optional`.
    public var wrappedType: Any.Type {
        return Wrapped.self
    }
}

extension Optional where Wrapped == Int {

    /// Checks if an object is `nil`.
    public var isNoneOrZero: Bool {
        return (self == nil) || (self == .zero)
    }
}
