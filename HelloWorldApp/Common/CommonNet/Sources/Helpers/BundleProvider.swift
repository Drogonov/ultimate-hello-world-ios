//
//  BundleProvider.swift
//  CommonNet
//
//  Created by Anton Vlezko on 16/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation

public final class BundleProvider {

    public static let shared = BundleProvider()

    private init() {
        loadAllBundles()
    }

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

    // Cache bundles and its content on first call
    private func loadAllBundles() {
        let url = Bundle.main.privateFrameworksURL!

        let fileManager = FileManager.default
        let bundlesURLS = try? fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: [.isDirectoryKey], options: [.skipsSubdirectoryDescendants])

        bundlesURLS?
            .compactMap { Bundle(url: $0) }
            .forEach { extractContentFileNames(in: $0) }

        extractContentFileNames(in: Bundle.main)
    }

    private func extractContentFileNames(in bundle: Bundle?) {
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

    private var bundlesContent = [Bundle.main: Set<String>()]
}
