//
//  OTPConfigurator.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Swinject
import CommonApplication
import Services
import Net

// MARK: - LoanConfigurator

final class OTPConfigurator {}

// MARK: - Assembly

extension OTPConfigurator: Assembly {

    func assemble(container: Container) {
        registerView(in: container)
        registerPresenter(in: container)
        registerRouter(in: container)
    }
}

// MARK: - Private Methods

fileprivate extension OTPConfigurator {
    func registerRouter(in container: Container) {
        container.register(OTPRouter.self) { _ in
            OTPRouter()
        }
        .initCompleted { resolver, instance in
            instance.sourceViewController = resolver.resolveSafe(OTPViewController.self)
        }
        .implements(OTPRouterInput.self)
    }

    func registerView(in container: Container) {
        container.register(OTPViewController.self) { _ in
            OTPViewController()
        }
        .initCompleted { resolver, instance in
            instance.moduleInput = resolver.resolve(OTPModuleInput.self)
            instance.presenter = resolver.resolveSafe(OTPPresenterInput.self)
        }
        .implements(OTPViewInput.self)
    }

    func registerPresenter(in container: Container) {
        container.register(OTPPresenter.self) { resolver in
            OTPPresenter(
                router: resolver.resolveSafe(OTPRouterInput.self)
            )
        }
        .initCompleted { resolver, instance in
            instance.view = resolver.resolveSafe(OTPViewInput.self)
            instance.authNetworkService = AuthNetworkService(
                api: AuthAPI(
                    networkClient: resolver.resolveSafe(
                        NetworkManagerProtocol.self,
                        name: NetworkManagerType.main
                    ),
                    errorHandler: NetworkServiceErrorHandler(
                        router: resolver.resolveSafe(AuthRouterInput.self)
                    )
                ),
                shortCacher: nil
            )
        }
        .implements(
            OTPPresenterInput.self,
            OTPModuleInput.self
        )
    }
}
