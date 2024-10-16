//
//  LanguageChangeService.swift
//  Services
//
//  Created by Anton Vlezko on 12/03/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Common
import CommonNet

// sourcery: AutoMockable
public protocol LanguageChangeServiceProtocol {
    func setupAppWith(language: Language)
    func getCurrentLanguage() -> Language?
}

public final class LanguageChangeService {
    public init() {}
}

// MARK: - LanguageChangeServiceProtocol

extension LanguageChangeService: LanguageChangeServiceProtocol {
    public func setupAppWith(language: Language) {
        let defaults = UserDefaults.standard

        defaults.set(language.rawValue, forKey: "AppleLanguage")
        defaults.synchronize()

        setLanguage(language.rawValue)
    }

    public func getCurrentLanguage() -> Language? {
        let defaults = UserDefaults.standard
        guard let code = defaults.string(forKey: "AppleLanguage") as String? else {
            return Language(rawValue: String(Locale.current.identifier.split(separator: "_").first ?? "en"))
        }

        return Language(rawValue: code)
    }
}

// MARK: - Private Method

fileprivate extension LanguageChangeService {

    func setLanguage(_ language: String) {
        guard let bundle = BundleProvider.shared.bundleForResourceName(language) else {
            return
        }

        let oneToken: String = bundle.bundleIdentifier ?? Constants.oneToken

        DispatchQueue.once(token: oneToken) {
            object_setClass(bundle, BundleEx.self as AnyClass)
        }

        if let path = bundle.path(forResource: language, ofType: Constants.resourcesType) {
            objc_setAssociatedObject(
                bundle,
                &_bundle,
                Bundle(path: path),
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        } else {
            objc_setAssociatedObject(
                bundle,
                &_bundle,
                nil,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}

fileprivate extension LanguageChangeService {
    enum Constants {
        static let oneToken: String = "bundleIdentifierOneToken"
        static let resourcesType: String = "lproj"
    }
}

// MARK: - Inner Types

/// use this extension to change lanuage in the app globally
/// var lang = "en"
/// let defaults = UserDefaults.standard
/// defaults.set(lang, forKey: "AppleLanguage")
/// defaults.synchronize()
/// Bundle.setLanguage(lang)

/// https://blog.devgenius.io/how-to-force-change-app-language-programmatically-without-breaking-your-app-1c73be9608e0

fileprivate var _bundle: UInt8 = 0

fileprivate class BundleEx: Bundle, @unchecked Sendable {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        let bundle: Bundle? = objc_getAssociatedObject(self, &_bundle) as? Bundle

        if let temp = bundle {
            return temp.localizedString(forKey: key, value: value, table: tableName)
        } else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
    }
}
