//
//  DeeplinkProcessorProtocol.swift
//  Deeplinks
//
//  Created by Anton Vlezko on 28/09/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import CommonNet

public protocol DeeplinkProcessorProtocol {
    func process(linkContent: DeeplinkContent)
    func setContext(_ context: DeeplinkProcessorContext)
}

public extension DeeplinkProcessorProtocol {
    func setContext(_ context: DeeplinkProcessorContext) {}
}
