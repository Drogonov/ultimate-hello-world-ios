//
//  MagicConfigurator.swift
//  Magic
//
//  Created by Anton Vlezko on 16/06/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Swinject
import Net
import Services
import CommonApplication

// MARK: - LoanConfigurator

final class MagicConfigurator {}

// MARK: - Assembly

extension MagicConfigurator: Assembly {

    func assemble(container: Container) {
        registerView(in: container)
        registerPresenter(in: container)
        registerRouter(in: container)
    }
}

// MARK: - Private Methods

fileprivate extension MagicConfigurator {

    func registerRouter(in container: Container) {
        container.register(MagicRouter.self) { _ in
            MagicRouter()
        }
        .initCompleted { resolver, instance in
            instance.sourceViewController = resolver.resolveSafe(MagicViewController.self)
        }
        .implements(MagicRouterInput.self)
    }

    func registerView(in container: Container) {
        container.register(MagicViewController.self) { _ in
            MagicViewController()
        }
        .initCompleted { resolver, instance in
            instance.moduleInput = resolver.resolve(MagicModuleInput.self)
            instance.presenter = resolver.resolveSafe(MagicPresenterInput.self)
        }
        .implements(MagicViewInput.self)
    }

    func registerPresenter(in container: Container) {
        container.register(MagicPresenter.self) { resolver in
            MagicPresenter(
                router: resolver.resolveSafe(MagicRouterInput.self)
            )
        }
        .initCompleted { resolver, instance in
            instance.view = resolver.resolveSafe(MagicViewInput.self)
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
            MagicPresenterInput.self,
            MagicModuleInput.self
        )
    }
}
