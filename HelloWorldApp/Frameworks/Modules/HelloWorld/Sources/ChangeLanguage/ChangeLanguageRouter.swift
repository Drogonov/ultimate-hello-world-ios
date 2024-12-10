//
//  ChangeLanguageRouter.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 10/06/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Services
import CommonApplication
import DI

// MARK: - ChangeLanguageRouter

final class ChangeLanguageRouter: BaseRouter {
    @DelayedImmutable var routing: HelloWorldModuleRoutingProtocol
}

// MARK: - ChangeLanguageRouterInput

extension ChangeLanguageRouter: ChangeLanguageRouterInput {
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

    func gotToAuth() {
        openAuthAsFirsNavigationController()
    }
}
