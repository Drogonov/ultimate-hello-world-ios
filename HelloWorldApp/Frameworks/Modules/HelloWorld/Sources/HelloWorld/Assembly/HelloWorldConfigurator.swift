//
//  HelloWorldConfigurator.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 12/03/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Swinject
import DI
import Services
import Net

// MARK: - LoanConfigurator

final class HelloWorldConfigurator {}

// MARK: - Assembly

extension HelloWorldConfigurator: Assembly {

    func assemble(container: Container) {
        registerView(in: container)
        registerPresenter(in: container)
        registerRouter(in: container)
    }
}

// MARK: - Private Methods

fileprivate extension HelloWorldConfigurator {

    func registerRouter(in container: Container) {
        container.register(HelloWorldRouter.self) { _ in
            HelloWorldRouter()
        }
        .initCompleted { resolver, instance in
            instance.sourceViewController = resolver.resolveSafe(HelloWorldViewController.self)
        }
        .implements(HelloWorldRouterInput.self)
    }

    func registerView(in container: Container) {
        container.register(HelloWorldViewController.self) { _ in
            HelloWorldViewController()
        }
        .initCompleted { resolver, instance in
            instance.moduleInput = resolver.resolve(HelloWorldModuleInput.self)
            instance.presenter = resolver.resolveSafe(HelloWorldPresenterInput.self)
        }
        .implements(HelloWorldViewInput.self)
    }

    func registerPresenter(in container: Container) {
        container.register(HelloWorldPresenter.self) { resolver in
            HelloWorldPresenter(
                router: resolver.resolveSafe(HelloWorldRouterInput.self)
            )
        }
        .initCompleted { resolver, instance in
            instance.view = resolver.resolveSafe(HelloWorldViewInput.self)
            instance.languageService = resolver.resolve(LanguageChangeServiceProtocol.self)
            instance.appNetworkService = AppNetworkService(
                api: AppAPI(
                    networkClient: resolver.resolveSafe(
                        NetworkManagerProtocol.self,
                        name: NetworkManagerType.main
                    ),
                    errorHandler: NetworkServiceErrorHandler()
                ),
                shortCacher: nil
            )
        }
        .implements(
            HelloWorldPresenterInput.self,
            HelloWorldModuleInput.self
        )
    }
}
