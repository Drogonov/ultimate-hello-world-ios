//
//  MainCoordinator.swift
//  HelloWorldApp
//
//  Created by Anton Vlezko on 11/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import UIKit
import DI
import Deeplinks
import CommonApplication
import Magic
import Persistence

protocol Coordinator {
    func start()
}

class MainCoordinator: Coordinator {

    // Properties
    private let window: UIWindow

    private var mainTabBarProvider: MainTabBarProviderProtocol?
    private var navigationStackService: NavigationStackServiceProtocol?
    private var sessionCache: CacheProtocol?


    init(
        window: UIWindow
    ) {
        self.window = window
        mainTabBarProvider = resolveDependency(MainTabBarProviderProtocol.self)
        navigationStackService = resolveDependency(NavigationStackServiceProtocol.self)
        sessionCache = resolveDependency(CacheProtocol.self, name: CacherType.long)
    }

    func start() {
        if shouldShowOnboarding() {
            showOnboarding()
        } else {
            showMainTabBar()
        }

        NavigationStackProvider.shared.navigationStack = window.rootViewController as? UINavigationController
        NavigationStackProvider.shared.set(isNavigationBarHidden: true)
    }

    private func shouldShowOnboarding() -> Bool {
        self.sessionCache?.read(Bool.self, withKey: CommonCacheKey.isUserSawOnboarding) ?? true
    }

    private func showOnboarding() {
        let navController = createOnboardingModule()
        window.rootViewController = navController
        self.sessionCache?.write(Bool.self, withKey: CommonCacheKey.isUserSawOnboarding)
    }

    private func showMainTabBar() {
        if let tabBarController = mainTabBarProvider?.provideMainTabBar() {
            window.rootViewController =  UINavigationController(rootViewController: tabBarController)
        }
    }

    private func createOnboardingModule() -> UINavigationController {
        let configurator = MVPModuleConfigurator(MagicFlowModuleFactory.onboardingModule())
        let viewController = configurator.getViewController()
        configurator.configure { (input: OnboardingModuleInput?) in
            input?.set(dataStorage: OnboardingDataStorage(
                onboardingText: "onboardingText",
                onboardingButtonText: "onboardingButtonText"
            ))
        }

        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}
