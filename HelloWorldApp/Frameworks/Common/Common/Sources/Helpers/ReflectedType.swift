//
//  ReflectedType.swift
//  Common
//
//  Created by Anton Vlezko on 16/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation

public struct ReflectedType {

    // MARK: Properties

    public let name: String
    public let fullName: String
    public let isOptional: Bool
    public let isImplicitlyUnwrappedOptional: Bool
    public let isProtocol: Bool

    // MARK: Construction

    internal init(
        name: String,
        fullName: String,
        isOptional: Bool,
        isImplicitlyUnwrappedOptional: Bool,
        isProtocol: Bool
    ) {
        // Init instance
        self.name = name
        self.fullName = fullName
        self.isOptional = isOptional
        self.isImplicitlyUnwrappedOptional = isImplicitlyUnwrappedOptional
        self.isProtocol = isProtocol
    }
}

