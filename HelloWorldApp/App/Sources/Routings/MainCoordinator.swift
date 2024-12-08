//
//  MainCoordinator.swift
//  App
//
//  Created by Anton Vlezko on 11/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import UIKit
import DI
import Deeplinks
import CommonApplication
import Magic
import Auth
import Persistence
import Resources
import Net

// MARK: Coordinator

protocol CoordinatorProtocol {
    func start()
}

// MARK: - MainCoordinator

class MainCoordinator: CoordinatorProtocol {

    // MARK: Properties

    private let window: UIWindow
    private var mainTabBarProvider: MainTabBarProviderProtocol?
    private var sessionCache: CacheProtocol?


    init(
        window: UIWindow
    ) {
        self.window = window
        mainTabBarProvider = resolveDependency(MainTabBarProviderProtocol.self)
        sessionCache = resolveDependency(CacheProtocol.self, name: CacherType.long)
    }

    func start() {
        switch (isUserSignedIn(), isUserSawOnboarding()) {
        case (true, true):
            showMainTabBar()

        case (true, false):
            showOnboarding()

        case (false, _):
            showAuth()
        }

        NavigationStackProvider.shared.navigationStack = window.rootViewController as? UINavigationController
        NavigationStackProvider.shared.set(isNavigationBarHidden: isUserSignedIn() && isUserSawOnboarding() )
    }
}

// MARK: - Private Methods

fileprivate extension MainCoordinator {
    func isUserSawOnboarding() -> Bool {
        self.sessionCache?.read(Bool.self, withKey: CommonCacheKey.isUserSawOnboarding) ?? false
    }

    func isUserSignedIn() -> Bool {
        KeychainJWTProvider.shared.get(.refreshToken) != nil
    }

    func showOnboarding() {
        let navController = createOnboardingModule()
        window.rootViewController = navController
        self.sessionCache?.write(true, withKey: CommonCacheKey.isUserSawOnboarding)
    }

    func showMainTabBar() {
        if let tabBarController = mainTabBarProvider?.provideMainTabBar() {
            let navController = UINavigationController(rootViewController: tabBarController)
            window.rootViewController =  navController
        }
    }

    func showAuth() {
        let navController = createAuthModule()
        window.rootViewController = navController
    }

    func createOnboardingModule() -> UINavigationController {
        let configurator = MVPModuleConfigurator(MagicFlowModuleFactory.onboardingModule())
        let viewController = configurator.getViewController()
        configurator.configure { (input: OnboardingModuleInput?) in
            input?.set(dataStorage: OnboardingDataStorage(
                onboardingText: ResourcesStrings.onboardingText(),
                onboardingButtonText: ResourcesStrings.onboardingButtonText()
            ))
        }

        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }

    func createAuthModule() -> UINavigationController {
        let configurator = MVPModuleConfigurator(AuthFlowModuleFactory.authModule())
        let viewController = configurator.getViewController()
        configurator.configure { (input: AuthModuleInput?) in
            input?.set(dataStorage: AuthDataStorage())
        }

        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}
