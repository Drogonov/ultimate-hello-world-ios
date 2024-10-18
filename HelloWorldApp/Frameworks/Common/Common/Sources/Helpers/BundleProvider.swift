//
//  BundleProvider.swift
//  Common
//
//  Created by Anton Vlezko on 16/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation

public final class BundleProvider {

    // MARK: Properties

    private var bundlesContent = [Bundle.main: Set<String>()]
    private var currentLanguageBundle: Bundle?

    // MARK: Construction

    public static let shared = BundleProvider()

    private init() {
        loadAllBundles()
        loadCurrentLanguageBundle()
    }

    // MARK: Methods

    public func bundleForClass(_ aClass: AnyClass) -> Bundle? {
        var result: Bundle?

        let resourceName = TypeCheckerProvider.shared.typeName(of: aClass).components(separatedBy: "<").first!

        result = bundleForResourceName(resourceName)

        return result
    }

    // Find bundle for resource with given name (don't pass extension)
    public func bundleForResourceName(_ resourceName: String) -> Bundle? {
        bundlesContent.first(where: { $0.value.contains(resourceName) })?.key
    }

    // Set current bundle with following language
    public func setLanguage(_ language: String) {
        currentLanguageBundle = loadBundle(for: language)
    }

    // Get localized string from current language bundle
    public func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        return currentLanguageBundle?.localizedString(forKey: key, value: value, table: tableName) ?? key
    }
}

fileprivate extension BundleProvider {
    // Cache bundles and its content on first call
    func loadAllBundles() {
        let url = Bundle.main.privateFrameworksURL!

        let fileManager = FileManager.default
        let bundlesURLS = try? fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: [.isDirectoryKey], options: [.skipsSubdirectoryDescendants])

        bundlesURLS?
            .compactMap { Bundle(url: $0) }
            .forEach { extractContentFileNames(in: $0) }

        extractContentFileNames(in: Bundle.main)
    }

    // Init current language bundle with saved language
    func loadCurrentLanguageBundle() {
        let language = UserDefaults.standard.string(forKey: Constants.languageKey) ?? Constants.defaultLanguage
        currentLanguageBundle = loadBundle(for: language)
    }

    func extractContentFileNames(in bundle: Bundle?) {
        guard let bundle = bundle else {
            return
        }

        let pathContents = try? FileManager.default.contentsOfDirectory(
            at: bundle.bundleURL,
            includingPropertiesForKeys: [.isRegularFileKey],
            options: [.skipsSubdirectoryDescendants]
        )

        let fileNames = pathContents?.compactMap { $0.deletingPathExtension().lastPathComponent } ?? []
        bundlesContent[bundle] = Set(fileNames)
    }

    func loadBundle(for language: String) -> Bundle? {
        guard let bundle = bundleForResourceName(language) else {
            return nil
        }

        if let path = bundle.path(forResource: language, ofType: Constants.resourcesType) {
            return Bundle(path: path)
        }

        return nil
    }
}

// MARK: - Constants

fileprivate extension BundleProvider {
    enum Constants {
        static let resourcesType: String = "lproj"
        static let languageKey: String = "AppleLanguage"
        static let defaultLanguage: String = "en"
    }
}
