//
//  HelloWorldRouter.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 12/03/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import DI
import Services
import CommonApplication

// MARK: - HelloWorldRouter

final class HelloWorldRouter: BaseRouter {}

// MARK: - HelloWorldRouterInput

extension HelloWorldRouter: HelloWorldRouterInput {
    func goToMoreInfoModule(dataStorage: MoreInfoDataStorage) {
        let configurator = MVPModuleConfigurator(HelloWorldFlowModuleFactory.moreInfoModule())
        let viewController = configurator.getViewController()
        configurator.configure { (input: MoreInfoModuleInput?) in
            input?.set(dataStorage: dataStorage)
        }

        show(viewController, animated: true)
    }
}
