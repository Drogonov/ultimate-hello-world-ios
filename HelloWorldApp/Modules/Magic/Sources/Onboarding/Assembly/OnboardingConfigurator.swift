//
//  OnboardingConfigurator.swift
//  Magic
//
//  Created by Anton Vlezko on 11/10/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Swinject

// MARK: - LoanConfigurator

final class OnboardingConfigurator {}

// MARK: - Assembly

extension OnboardingConfigurator: Assembly {

    func assemble(container: Container) {
        registerView(in: container)
        registerPresenter(in: container)
        registerRouter(in: container)
    }
}

// MARK: - Private Methods

fileprivate extension OnboardingConfigurator {
    func registerRouter(in container: Container) {
        container.register(OnboardingRouter.self) { _ in
            OnboardingRouter()
        }
        .initCompleted { resolver, instance in
            instance.sourceViewController = resolver.resolveSafe(OnboardingViewController.self)
        }
        .implements(OnboardingRouterInput.self)
    }

    func registerView(in container: Container) {
        container.register(OnboardingViewController.self) { _ in
            OnboardingViewController()
        }
        .initCompleted { resolver, instance in
            instance.moduleInput = resolver.resolve(OnboardingModuleInput.self)
            instance.presenter = resolver.resolveSafe(OnboardingPresenterInput.self)
        }
        .implements(OnboardingViewInput.self)
    }

    func registerPresenter(in container: Container) {
        container.register(OnboardingPresenter.self) { resolver in
            OnboardingPresenter(
                router: resolver.resolveSafe(OnboardingRouterInput.self)
            )
        }
        .initCompleted { resolver, instance in
            instance.view = resolver.resolveSafe(OnboardingViewInput.self)
        }
        .implements(
            OnboardingPresenterInput.self,
            OnboardingModuleInput.self
        )
    }
}
