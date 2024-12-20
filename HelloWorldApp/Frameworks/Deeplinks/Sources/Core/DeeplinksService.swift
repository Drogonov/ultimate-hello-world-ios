//
//  DeeplinksService.swift
//  Deeplinks
//
//  Created by Anton Vlezko on 28/09/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import CommonApplication

public final class DeeplinksService: DeeplinksServiceProtocol {

    public init() {}

    public var context: DeeplinkProcessorContext?

    public var linkContent: DeeplinkContent? {
        DeeplinksManager.shared.linkContent
    }

    public func handleDeeplink(content: DeeplinkContent, executeHandler: Bool) {
        DeeplinksManager.shared.handleDeeplink(content: content, executeHandler: executeHandler, context: context)
    }

    public func canHandleLink(url: URL) -> Bool {
        DeeplinksManager.shared.canHandleLink(url: url)
    }

    public func canHandleLink(content: DeeplinkContent) -> Bool {
        DeeplinksManager.shared.canHandleLink(content: content)
    }

    public func reset() {
        DeeplinksManager.shared.reset()
    }

    public func resetProcessors() {
        DeeplinksManager.shared.resetProcessors()
    }
}
