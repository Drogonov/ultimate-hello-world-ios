//
//  AppLanguage.swift
//  Common
//
//  Created by Anton Vlezko on 12/03/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

/// use this extension for changing language in current line globally in the app
/// AppLanguage.shared.language = Language.english.rawValue
/// let preferredLanguage = R.string.localizable.elephant(preferredLanguages: [AppLanguage.shared.language])
/// https://medium.com/@dayton159/strong-typed-resources-management-with-r-swift-1e3c8093ea41

public enum Language: String {
    case english = "en"
    case russian = "ru"

    static func map(value: String) -> Self {
        switch value {
        case Language.english.rawValue:
            return .english
        case Language.russian.rawValue:
            return .russian
        default:
            return .english
        }
    }
}
