//
//  MagicDeeplinkFlowProcessorFactory.swift
//  Deeplinks
//
//  Created by Anton Vlezko on 28/09/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import DI
import Foundation
import Swinject
import CommonNet

public protocol DeeplinkFlowProcessorFactoryProtocol {
    var resolver: Resolver { get }

    func getProcessor(linkContent: DeeplinkContent) -> DeeplinkProcessorProtocol
}

public extension DeeplinkFlowProcessorFactoryProtocol {

    func getProcessor(linkContent: DeeplinkContent) -> DeeplinkProcessorProtocol {
        resolver.resolveSafe(DeeplinkProcessorProtocol.self, name: linkContent.type.rawValue)
    }
}

final class DeeplinkFlowProcessorFactory: DeeplinkFlowProcessorFactoryProtocol {

    var resolver: Resolver = {
        let configurators: [Assembly] = [
            MagicDeeplinkConfigurator()
        ]

        DIAssembler.apply(configurators)

        return DIAssembler.resolver
    }()
}
