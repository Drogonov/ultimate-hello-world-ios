//
//  ___VARIABLE_productName___DeeplinkConfigurator.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import DI
import UIKit
import Swinject
import CommonNet

final class ___VARIABLE_productName___DeeplinkConfigurator: Assembly {

    func assemble(container: Container) {
        registerRouter(in: container)
        registerProcessor(in: container)
    }
}

// MARK: - Private functions

fileprivate extension ___VARIABLE_productName___DeeplinkConfigurator {

    func registerRouter(in container: Container) {
        container.register(___VARIABLE_productName___DeeplinkRouter.self) { resolver in
            ___VARIABLE_productName___DeeplinkRouter()
        }
        .implements(___VARIABLE_productName___DeeplinkRouterProtocol.self)
    }

    func registerProcessor(in container: Container) {
        container.register(___VARIABLE_productName___DeeplinkProcessor.self) { resolver in
            ___VARIABLE_productName___DeeplinkProcessor()
        }
        .initCompleted { resolver, instance in
            instance.router = resolver.resolveSafe()
        }
//        .implements(DeeplinkProcessorProtocol.self, name: DeeplinkType.___VARIABLE_productName___.rawValue)
    }
}

