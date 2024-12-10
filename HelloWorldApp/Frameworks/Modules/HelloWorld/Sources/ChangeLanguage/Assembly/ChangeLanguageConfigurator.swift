//
//  ChangeLanguageConfigurator.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 10/06/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Swinject
import Services
import Net

// MARK: - LoanConfigurator

final class ChangeLanguageConfigurator {}

// MARK: - Assembly

extension ChangeLanguageConfigurator: Assembly {

    func assemble(container: Container) {
        registerView(in: container)
        registerPresenter(in: container)
        registerRouter(in: container)
    }
}

// MARK: - Private Methods

fileprivate extension ChangeLanguageConfigurator {

    func registerRouter(in container: Container) {
        container.register(ChangeLanguageRouter.self) { _ in
            ChangeLanguageRouter()
        }
        .initCompleted { resolver, instance in
            instance.sourceViewController = resolver.resolveSafe(ChangeLanguageViewController.self)
        }
        .implements(ChangeLanguageRouterInput.self)
    }

    func registerView(in container: Container) {
        container.register(ChangeLanguageViewController.self) { _ in
            ChangeLanguageViewController()
        }
        .initCompleted { resolver, instance in
            instance.moduleInput = resolver.resolve(ChangeLanguageModuleInput.self)
            instance.presenter = resolver.resolveSafe(ChangeLanguagePresenterInput.self)
        }
        .implements(ChangeLanguageViewInput.self)
    }

    func registerPresenter(in container: Container) {
        container.register(ChangeLanguagePresenter.self) { resolver in
            ChangeLanguagePresenter(
                router: resolver.resolveSafe(ChangeLanguageRouterInput.self)
            )
        }
        .initCompleted { resolver, instance in
            instance.view = resolver.resolveSafe(ChangeLanguageViewInput.self)
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
            ChangeLanguagePresenterInput.self,
            ChangeLanguageModuleInput.self
        )
    }
}
