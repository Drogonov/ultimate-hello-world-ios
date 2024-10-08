//
//  DeeplinkProcessorModuleOutput.swift
//  Deeplinks
//
//  Created by Anton Vlezko on 28/09/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import CommonNet

public protocol DeeplinkProcessorModuleOutput: AnyObject {

    /// Call this method if you need perform some actions after user taps "Ok" on error message alert.
    func didConfirmError()

    /// Call this method in your processor module right after router call to notify module output that some screen is being opened.
    func deeplinkProcessor(_ deeplinkProcessor: DeeplinkProcessorProtocol, didOpenLink content: DeeplinkContent)

    /// Call this method somewhere in your processor module to notify module output that some screen is being closed.
    func deeplinkProcessor(_ deeplinkProcessor: DeeplinkProcessorProtocol, didFinishFlowFor content: DeeplinkContent)
}

public extension DeeplinkProcessorModuleOutput {

    func didConfirmError() {
        // Optional method
    }

    func deeplinkProcessor(_ deeplinkProcessor: DeeplinkProcessorProtocol, didOpenLink content: DeeplinkContent) {
        // Optional method
    }

    func deeplinkProcessor(_ deeplinkProcessor: DeeplinkProcessorProtocol, didFinishFlowFor content: DeeplinkContent) {
        // Optional method
    }
}
