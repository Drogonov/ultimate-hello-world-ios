//
//  AuthConfigurator.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Swinject

// MARK: - LoanConfigurator

final class AuthConfigurator {}

// MARK: - Assembly

extension AuthConfigurator: Assembly {

    func assemble(container: Container) {
        registerView(in: container)
        registerPresenter(in: container)
        registerRouter(in: container)
    }
}

// MARK: - Private Methods

fileprivate extension AuthConfigurator {
    func registerRouter(in container: Container) {
        container.register(AuthRouter.self) { _ in
            AuthRouter()
        }
        .initCompleted { resolver, instance in
            instance.sourceViewController = resolver.resolveSafe(AuthViewController.self)
        }
        .implements(AuthRouterInput.self)
    }

    func registerView(in container: Container) {
        container.register(AuthViewController.self) { _ in
            AuthViewController()
        }
        .initCompleted { resolver, instance in
            instance.moduleInput = resolver.resolve(AuthModuleInput.self)
            instance.presenter = resolver.resolveSafe(AuthPresenterInput.self)
        }
        .implements(AuthViewInput.self)
    }

    func registerPresenter(in container: Container) {
        container.register(AuthPresenter.self) { resolver in
            AuthPresenter(
                router: resolver.resolveSafe(AuthRouterInput.self)
            )
        }
        .initCompleted { resolver, instance in
            instance.view = resolver.resolveSafe(AuthViewInput.self)
        }
        .implements(
            AuthPresenterInput.self,
            AuthModuleInput.self
        )
    }
}
