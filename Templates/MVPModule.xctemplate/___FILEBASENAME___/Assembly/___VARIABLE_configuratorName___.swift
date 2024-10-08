//
//  ___VARIABLE_configuratorName___.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Swinject

// MARK: - LoanConfigurator

final class ___VARIABLE_productName___Configurator {}

// MARK: - Assembly

extension ___VARIABLE_productName___Configurator: Assembly {

    func assemble(container: Container) {
        registerView(in: container)
        registerPresenter(in: container)
        registerRouter(in: container)
    }
}

// MARK: - Private Methods

fileprivate extension ___VARIABLE_productName___Configurator {
    func registerRouter(in container: Container) {
        container.register(___VARIABLE_productName___Router.self) { _ in
            ___VARIABLE_productName___Router()
        }
        .initCompleted { resolver, instance in
            instance.sourceViewController = resolver.resolveSafe(___VARIABLE_productName___ViewController.self)
        }
        .implements(___VARIABLE_productName___RouterInput.self)
    }

    func registerView(in container: Container) {
        container.register(___VARIABLE_productName___ViewController.self) { _ in
            ___VARIABLE_productName___ViewController()
        }
        .initCompleted { resolver, instance in
            instance.moduleInput = resolver.resolve(___VARIABLE_productName___ModuleInput.self)
            instance.presenter = resolver.resolveSafe(___VARIABLE_productName___PresenterInput.self)
        }
        .implements(___VARIABLE_productName___ViewInput.self)
    }

    func registerPresenter(in container: Container) {
        container.register(___VARIABLE_productName___Presenter.self) { resolver in
            ___VARIABLE_productName___Presenter(
                router: resolver.resolveSafe(___VARIABLE_productName___RouterInput.self)
            )
        }
        .initCompleted { resolver, instance in
            instance.view = resolver.resolveSafe(___VARIABLE_productName___ViewInput.self)
        }
        .implements(
            ___VARIABLE_productName___PresenterInput.self,
            ___VARIABLE_productName___ModuleInput.self
        )
    }
}
