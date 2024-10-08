//
//  Bundle+Extension.swift
//  Common
//
//  Created by Anton Vlezko on 12/03/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

/// use this extension to change lanuage in the app globally
/// var lang = "en"
/// let defaults = UserDefaults.standard
/// defaults.set(lang, forKey: "AppleLanguage")
/// defaults.synchronize()
/// Bundle.setLanguage(lang)

/// https://blog.devgenius.io/how-to-force-change-app-language-programmatically-without-breaking-your-app-1c73be9608e0

var _bundle: UInt8 = 0
var _frameworkBundle: UInt8 = 0

private class BundleEx: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        let bundle: Bundle? = objc_getAssociatedObject(self, &_bundle) as? Bundle

        if let temp = bundle {
            return temp.localizedString(forKey: key, value: value, table: tableName)
        } else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
    }
}

// # TODO: Rewrite bundle id to save language safe
/// It is not the best way to do it try to rewrite code later.Becouse Resources target can have other names
public extension Bundle {
    class func setLanguage(_ language: String?) {
        let oneToken: String = Bundle.main.bundleIdentifier ?? "com.drogonov.HelloWorldApp"

        guard let frameworkBundle = Bundle(identifier: "com.drogonov.HelloWorldApp.Resources") else {
            return
        }

        DispatchQueue.once(token: oneToken) {
            print("Do This Once!")
            object_setClass(Bundle.main, BundleEx.self as AnyClass)
            object_setClass(Bundle(identifier: "com.drogonov.HelloWorldApp.Resources"), BundleEx.self as AnyClass)
        }

        if let temp = language,
           let path = frameworkBundle.path(forResource: temp, ofType: "lproj") {
            objc_setAssociatedObject(
                frameworkBundle,
                &_bundle,
                Bundle(path: path),
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        } else {
            objc_setAssociatedObject(
                frameworkBundle,
                &_bundle,
                nil,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}
