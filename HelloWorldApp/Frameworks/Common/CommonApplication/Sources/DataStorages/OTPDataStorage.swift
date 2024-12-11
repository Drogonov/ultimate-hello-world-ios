//
//  OTPDataStorage.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import DI

public protocol OTPModuleInput: MVPModuleInputProtocol {
    func set(dataStorage: OTPDataStorage)
}

// MARK: - OTPDataStorage

public struct OTPDataStorage {

    // MARK: Public Properties

    public let email: String
    public let password: String

    // MARK: Init
    // Move to CommonApplication if you want to use it with deeplinks 

    public init(
        email: String,
        password: String
    ) {
        self.email = email
        self.password = password
    }
}
