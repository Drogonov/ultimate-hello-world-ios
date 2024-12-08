//
//  JWTProvider.swift
//  Net
//
//  Created by Anton Vlezko on 26/11/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import KeychainAccess

public enum JWTType: String {
    case accessToken
    case refreshToken
}

public protocol JWTProvider {
    func get(_ tokenType: JWTType) -> String?
    func save(_ tokenType: JWTType, _ token: String)
    func deleteToken(_ tokenType: JWTType)
}

public class KeychainJWTProvider {

    // MARK: Properties

    static public let shared: KeychainJWTProvider = KeychainJWTProvider()

    // MARK: Private Properties

    private let keychain: Keychain

    // MARK: Init

    private init() {
        self.keychain = Keychain(service: "KeychainJWTProvider")
    }
}

extension KeychainJWTProvider: JWTProvider {
    public func get(_ tokenType: JWTType) -> String? {
        return keychain[tokenType.rawValue]
    }

    public func save(_ tokenType: JWTType, _ token: String) {
        keychain[tokenType.rawValue] = token
    }

    public func deleteToken(_ tokenType: JWTType) {
        keychain[tokenType.rawValue] = nil
    }
}
