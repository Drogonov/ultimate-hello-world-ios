//
//  MoreInfoProtocols.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 16/06/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import DI
import Services
import CommonApplication

// MARK: - MoreInfoRouter

final class MoreInfoRouter: BaseRouter {
    @DelayedImmutable var routing: HelloWorldModuleRoutingProtocol
}

// MARK: - MoreInfoRouterInput

extension MoreInfoRouter: MoreInfoRouterInput {
    func goToMagicScreen(dataStorage: MagicDataStorage) {
        let factory = routing.getMagicModuleFactory()
        let configurator = MVPModuleConfigurator(factory)

        let viewController = configurator.getViewController()
        configurator.configure { (input: MagicModuleInput?) in
            input?.set(dataStorage: dataStorage)
        }

        pushOnFirstNavigationController(
            viewController,
            animated: true
        )
    }
}
