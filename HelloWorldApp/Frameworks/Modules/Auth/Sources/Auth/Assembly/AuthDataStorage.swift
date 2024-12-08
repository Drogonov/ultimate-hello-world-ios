//
//  AuthDataStorage.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation

// MARK: - AuthDataStorage

public struct AuthDataStorage {

    // MARK: Public Properties

    public let response: String

    // MARK: Init
    // Move to CommonApplication if you want to use it with deeplinks 

    public init(
        response: String = "Hello World!"
    ) {
        self.response = response
    }
}
