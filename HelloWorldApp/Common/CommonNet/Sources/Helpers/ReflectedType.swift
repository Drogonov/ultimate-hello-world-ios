//
//  ReflectedType.swift
//  CommonNet
//
//  Created by Anton Vlezko on 20/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

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
