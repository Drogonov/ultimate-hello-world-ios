//
//  MagicDeeplinkConfigurator.swift
//  Deeplinks
//
//  Created by Anton Vlezko on 28/09/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import DI
import UIKit
import Swinject
import CommonNet

final class MagicDeeplinkConfigurator: Assembly {

    func assemble(container: Container) {
        registerRouter(in: container)
        registerProcessor(in: container)
    }
}

// MARK: - Private functions

fileprivate extension MagicDeeplinkConfigurator {

    func registerRouter(in container: Container) {
        container.register(MagicDeeplinkRouter.self) { resolver in
            MagicDeeplinkRouter()
        }
        .implements(MagicDeeplinkRouterProtocol.self)
    }

    func registerProcessor(in container: Container) {
        container.register(MagicDeeplinkProcessor.self) { resolver in
            MagicDeeplinkProcessor()
        }
        .initCompleted { resolver, instance in
            instance.router = resolver.resolveSafe()
        }
        .implements(DeeplinkProcessorProtocol.self, name: DeeplinkType.magic.rawValue)
    }
}
