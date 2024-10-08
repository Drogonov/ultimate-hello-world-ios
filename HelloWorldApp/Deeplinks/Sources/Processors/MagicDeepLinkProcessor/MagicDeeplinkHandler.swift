//
//  MagicDeeplinkHandler.swift
//  Deeplinks
//
//  Created by Anton Vlezko on 28/09/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import CommonNet

final public class MagicDeeplinkHandler: AbstractDeeplinkHandler {

    public override var linkTypes: Set<DeeplinkType> {
        [.magic]
    }

    public override func getProcessor(
        linkContent: DeeplinkContent,
        context: DeeplinkProcessorContext
    ) -> DeeplinkProcessorProtocol {
        DeeplinkFlowProcessorFactory().getProcessor(linkContent: linkContent)
    }
}
