//
//  DeeplinkManager.swift
//  Deeplinks
//
//  Created by Anton Vlezko on 27/09/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import DI
import Foundation
import UIKit
import CommonNet
import Persistence
import MasterComponents

@objcMembers
public final class DeeplinksManager: NSObject {

    // MARK: Properties

    public static let shared = DeeplinksManager()

    /// Current deep link content.
    /// Not nil in two cases:
    /// - There is some processor resolving happens right now;
    /// - There was 'executeHandler = false' flag passed to delay link handling for some reason
    public var linkContent: DeeplinkContent?
    public var linkService: SchemeLessLinkServiceProtocol?
    public var sessionCache: CacheProtocol?

    // MARK: Init

    private override init() { }

    // MARK: Methods

    public func register(handler: DeeplinkHandlerProtocol) {
        self.handler = handler
    }

    /// Handles deep link content
    /// - Parameters:
    ///   - content: Content to handle
    ///   - executeHandler: In some cases you may not want to handle deep link content instantly, so this flag for the resque.
    ///   It is only stores link content inside 'linkContent' property of this manager so you can execute it later.
    ///   - context: Presentation context for deep link processor. Usually contains reference to presenting view cotnroller and the 'output' object for feedback.
    public func handleDeeplink(content: DeeplinkContent, executeHandler: Bool = true, context: DeeplinkProcessorContext? = nil) {

        guard executeHandler, let context = context else {
            linkContent = content
            return
        }

        var realContent = content

        if linkService?.isSchemeLesslink(link: content.url.absoluteString) == true,
           let realURL = linkService?.convertSchemeLessLinkToHttps(urlString: content.url.absoluteString) {
            realContent = DeeplinkContent(
                url: realURL,
                type: content.type,
                parameters: content.parameters,
                option: content.processingOption
            )
        }

        handler?.handle(linkContent: realContent, context: context)
        reset()
    }

    ///
    /// - Parameter url: URL to check
    /// - Returns: True if link is valid and can be handled by one of registered handler otherwise false
    public func canHandleLink(url: URL) -> Bool {
        var result = false

        if let content = DeeplinkContent(urlString: url.absoluteString, isExternal: false), canHandleLink(content: content) {
            result = true
        }

        return result
    }

    ///
    /// - Parameter content: LinkContent to check
    /// - Returns: True if there is some handler registered for passed content type
    public func canHandleLink(content: DeeplinkContent) -> Bool {
        var handler = handler

        while handler != nil {
            if handler?.canHandle(linkContent: content) == true {
                return true
            }

            handler = handler?.next
        }

        return false
    }

    /// Resets link content
    public func reset() {
        linkContent = nil
    }

    /// Resets current processor
    public func resetProcessors() {
        currentProcessor = nil
        handler?.resetProcessors()
    }

    private var handler: DeeplinkHandlerProtocol?

    private var currentProcessor: DeeplinkProcessorProtocol?
}

// MARK: - UIApplicationDelegate

extension DeeplinksManager: UIApplicationDelegate {

    public func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {

        /// Avoid bugs when no internet connection on requests when the app goes into foreground.
        /// https://stackoverflow.com/questions/63621039/requests-run-when-my-app-will-enter-foreground-fail-with-the-network-connection
        DispatchQueue.main.asyncAfter(deadline: .now() + MCConstants.standardAnimationDuration) {
            if userActivity.activityType == NSUserActivityTypeBrowsingWeb,
                let urlString = userActivity.webpageURL?.absoluteString,
                let content = DeeplinkContent(urlString: urlString, isExternal: true),
                let keyWindow = UIApplication.shared.currentKeyWindow,
                let rootViewConrollr = keyWindow.rootViewController {

                /// Checking if we are logged in, execute Deeplink right now, else wait until login:
                DeeplinksManager.shared.handleDeeplink(
                    content: content,
                    executeHandler: self.sessionCache?.read(Bool.self, withKey: CommonCacheKey.isUserLoggedIn) ?? false,
                    context: DeeplinkProcessorContext(viewController: rootViewConrollr, moduleOutput: nil)
                )
            }
        }

        return true
    }

    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + MCConstants.standardAnimationDuration) {
            guard let keyWindow = UIApplication.shared.currentKeyWindow,
                  let rootViewController = keyWindow.rootViewController,
                  let content = DeeplinkContent(urlString: url.absoluteString, isExternal: true) else {
                return
            }

            DeeplinksManager.shared.handleDeeplink(
                content: content,
                executeHandler: self.sessionCache?.read(Bool.self, withKey: CommonCacheKey.isUserLoggedIn) ?? false,
                context: DeeplinkProcessorContext(viewController: rootViewController, moduleOutput: nil)
            )
        }

        return true
    }
}
