//
//  LanguageChangeService.swift
//  Services
//
//  Created by Anton Vlezko on 12/03/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Common

// sourcery: AutoMockable
public protocol LanguageChangeServiceProtocol {
    func setupAppWith(language: Language)
    func getCurrentLanguage() -> Language?
}

public final class LanguageChangeService: LanguageChangeServiceProtocol {
    public init() {}
    
    public func setupAppWith(language: Language) {
        let defaults = UserDefaults.standard

        defaults.set(language.rawValue, forKey: "AppleLanguage")
        defaults.synchronize()

        Bundle.setLanguage(language.rawValue)
    }

    public func getCurrentLanguage() -> Language? {
        let defaults = UserDefaults.standard
        guard let code = defaults.string(forKey: "AppleLanguage") as String? else {
            return Language(rawValue: String(Locale.current.identifier.split(separator: "_").first ?? "en"))
        }

        return Language(rawValue: code)
    }
}
