//
//  MainTabBarProvider.swift
//  App
//
//  Created by Anton Vlezko on 11/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import UIKit
import HelloWorld
import DI
import CommonApplication
import Auth
import Magic
import Resources

class MainTabBarProvider: MainTabBarProviderProtocol {

    // MARK: Methods

    func provideMainTabBar() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .accentColor
        let controllers = [
            createHelloWorldModule(),
            createChangeLanguageModule()
        ]

        tabBarController.viewControllers = controllers

        return tabBarController
    }

    func provideAuth() -> UIViewController {
        createAuthModule()
    }

    func provideOnboarding() -> UIViewController {
        createOnboardingModule()
    }
}

// MARK: - Private Methods

fileprivate extension MainTabBarProvider {
    func createHelloWorldModule() -> UINavigationController {
        let configurator = MVPModuleConfigurator(HelloWorldFlowModuleFactory.helloWorldModule())
        let viewController = configurator.getViewController()
        configurator.configure { (input: HelloWorldModuleInput?) in
            input?.set(dataStorage: HelloWorldDataStorage())
        }

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )

        return navigationController
    }

    func createChangeLanguageModule() -> UINavigationController {
        let configurator = MVPModuleConfigurator(HelloWorldFlowModuleFactory.changeLanguageModule())
        let viewController = configurator.getViewController()
        configurator.configure { (input: ChangeLanguageModuleInput?) in
            input?.set(dataStorage: ChangeLanguageDataStorage())
        }

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(
            title: "Language",
            image: UIImage(systemName: "globe.central.south.asia"),
            selectedImage: UIImage(systemName: "globe.central.south.asia.fill")
        )

        return navigationController
    }

    func createOnboardingModule() -> UIViewController {
        let configurator = MVPModuleConfigurator(MagicFlowModuleFactory.onboardingModule())
        let viewController = configurator.getViewController()
        configurator.configure { (input: OnboardingModuleInput?) in
            input?.set(dataStorage: OnboardingDataStorage(
                onboardingText: ResourcesStrings.onboardingText(),
                onboardingButtonText: ResourcesStrings.onboardingButtonText()
            ))
        }

        return viewController
    }

    func createAuthModule() -> UIViewController {
        let configurator = MVPModuleConfigurator(AuthFlowModuleFactory.authModule())
        let viewController = configurator.getViewController()
        configurator.configure { (input: AuthModuleInput?) in
            input?.set(dataStorage: AuthDataStorage())
        }

        return viewController
    }
}
