//
//  MoreInfoConfigurator.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 16/06/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Swinject
import Services
import Net
import DI
import UIKit
import CommonApplication

// MARK: - LoanConfigurator

final class MoreInfoConfigurator {}

// MARK: - Assembly

extension MoreInfoConfigurator: Assembly {

    func assemble(container: Container) {
        registerView(in: container)
        registerPresenter(in: container)
        registerRouter(in: container)
    }
}

// MARK: - Private Methods

fileprivate extension MoreInfoConfigurator {

    func registerRouter(in container: Container) {
        container.register(MoreInfoRouter.self) { _ in
            MoreInfoRouter()
        }
        .initCompleted { resolver, instance in
            instance.sourceViewController = resolver.resolveSafe(MoreInfoViewController.self)
            instance.routing = resolver.resolveSafe(HelloWorldModuleRoutingProtocol.self)
        }
        .implements(MoreInfoRouterInput.self)
    }

    func registerView(in container: Container) {
        container.register(MoreInfoViewController.self) { _ in
            MoreInfoViewController()
        }
        .initCompleted { resolver, instance in
            instance.moduleInput = resolver.resolve(MoreInfoModuleInput.self)
            instance.presenter = resolver.resolveSafe(MoreInfoPresenterInput.self)
        }
        .implements(MoreInfoViewInput.self)
    }

    func registerPresenter(in container: Container) {
        container.register(MoreInfoPresenter.self) { resolver in
            MoreInfoPresenter(
                router: resolver.resolveSafe(MoreInfoRouterInput.self)
            )
        }
        .initCompleted { resolver, instance in
            instance.view = resolver.resolveSafe(MoreInfoViewInput.self)
            instance.languageService = resolver.resolve(LanguageChangeServiceProtocol.self)
            instance.appNetworkService = AppNetworkService(
                api: AppAPI(
                    networkClient: resolver.resolveSafe(
                        NetworkManagerProtocol.self,
                        name: NetworkManagerType.main
                    ),
                    errorHandler: NetworkServiceErrorHandler(
                        router: resolver.resolveSafe(MoreInfoRouterInput.self)
                    )
                ),
                shortCacher: nil
            )
            var deeplinksService = resolver.resolve(DeeplinksServiceProtocol.self)
            deeplinksService?.context = DeeplinkProcessorContext(
                viewController: resolver.resolveSafe(MoreInfoViewInput.self) as? UIViewController,
                moduleOutput: nil
            )
            instance.deeplinksService = deeplinksService
        }
        .implements(
            MoreInfoPresenterInput.self,
            MoreInfoModuleInput.self
        )
    }
}
