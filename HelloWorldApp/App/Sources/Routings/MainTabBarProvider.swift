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

class MainTabBarProvider: MainTabBarProviderProtocol {
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
}

extension MainTabBarProvider {
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
}
