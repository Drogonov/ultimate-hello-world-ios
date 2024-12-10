//
//  OTPDataStorage.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation

// MARK: - OTPDataStorage

public struct OTPDataStorage {

    // MARK: Public Properties

    public let email: String

    // MARK: Init
    // Move to CommonApplication if you want to use it with deeplinks 

    public init(
        email: String
    ) {
        self.email = email
    }
}
