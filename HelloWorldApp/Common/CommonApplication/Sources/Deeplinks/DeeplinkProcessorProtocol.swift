//
//  DeeplinkProcessorProtocol.swift
//  CommonApplication
//
//  Created by Anton Vlezko on 17/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import CommonNet

public protocol DeeplinkProcessorProtocol {
    func process(linkContent: DeeplinkContent)
    func setContext(_ context: DeeplinkProcessorContext)
}

public extension DeeplinkProcessorProtocol {
    func setContext(_ context: DeeplinkProcessorContext) {}
}

