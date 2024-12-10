//
//  AuthDataStorage.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import DI

public protocol AuthModuleInput: MVPModuleInputProtocol {
    func set(dataStorage: AuthDataStorage)
}

// MARK: - AuthDataStorage

public struct AuthDataStorage {

    // MARK: Init
    // Move to CommonApplication if you want to use it with deeplinks 

    public init() {}
}
