//
//  HelloWorldAppRoutingConfigurator.swift
//  HelloWorldApp
//
//  Created by Anton Vlezko on 11/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import DI
import Swinject
import HelloWorld

final class HelloWorldAppRoutingConfigurator: Assembly {

    func assemble(container: Container) {
        registerHelloWorldModuleRouting(in: container)
    }
}

fileprivate extension HelloWorldAppRoutingConfigurator {

    func registerHelloWorldModuleRouting(in container: Container) {
        container.register(HelloWorldModuleRoutingProtocol.self) { _ in
            HelloWorldModuleRouting()
        }
        .implements(HelloWorldModuleRoutingProtocol.self)
    }
}
