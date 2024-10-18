//
//  DeeplinksServiceProtocol.swift
//  CommonApplication
//
//  Created by Anton Vlezko on 17/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
public protocol DeeplinksServiceProtocol {
    var linkContent: DeeplinkContent? { get }
    var context: DeeplinkProcessorContext? { get set }

    func handleDeeplink(content: DeeplinkContent, executeHandler: Bool)
    func canHandleLink(url: URL) -> Bool
    func canHandleLink(content: DeeplinkContent) -> Bool

    func reset()
    func resetProcessors()
}
