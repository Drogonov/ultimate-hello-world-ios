//
//  AppRoutingConfigurator.swift
//  App
//
//  Created by Anton Vlezko on 11/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import DI
import Swinject
import HelloWorld
import Auth
import CommonApplication

final class AppRoutingConfigurator: Assembly {

    func assemble(container: Container) {
        registerMainTabBarProvider(in: container)
        registerHelloWorldModuleRouting(in: container)
        registerAuthModuleRouting(in: container)
    }
}

fileprivate extension AppRoutingConfigurator {

    func registerMainTabBarProvider(in container: Container) {
        container.register(MainTabBarProviderProtocol.self) { _ in
            MainTabBarProvider()
        }
        .implements(MainTabBarProviderProtocol.self)
    }

    func registerHelloWorldModuleRouting(in container: Container) {
        container.register(HelloWorldModuleRoutingProtocol.self) { _ in
            HelloWorldModuleRouting()
        }
        .implements(HelloWorldModuleRoutingProtocol.self)
    }

    func registerAuthModuleRouting(in container: Container) {
        container.register(AuthModuleRoutingProtocol.self) { _ in
            AuthModuleRouting()
        }
        .implements(AuthModuleRoutingProtocol.self)
    }
}
