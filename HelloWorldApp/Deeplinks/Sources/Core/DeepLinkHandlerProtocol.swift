//
//  DeeplinkHandlerProtocol.swift
//  Deeplinks
//
//  Created by Anton Vlezko on 28/09/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import CommonNet

public protocol DeeplinkHandlerProtocol {
    var next: DeeplinkHandlerProtocol? { get }

    func handle(linkContent: DeeplinkContent, context: DeeplinkProcessorContext)
    func canHandle(linkContent: DeeplinkContent) -> Bool
    func resetProcessors()
}
