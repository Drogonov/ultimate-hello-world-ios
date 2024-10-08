//
//  SceneDelegate.swift
//  HelloWorldApp
//
//  Created by Anton Vlezko on 12/03/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import UIKit
import DI
import HelloWorld
import Magic
import Services
import CommonApplication
import Deeplinks
import CommonNet

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: Properties

    var window: UIWindow?
    var deeplinksService: DeeplinksServiceProtocol?
    var navigationStackService: NavigationStackServiceProtocol?

    // MARK: Methods

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: scene)
        window?.makeKeyAndVisible()

        // # TODO: Add Onboarding screen to show how to manage scenes and use navigation stack
        let tabBarController = UITabBarController()
        let controllers = [
            createHelloWorldModule(),
            createChangeLanguageModule()
        ]

        tabBarController.viewControllers = controllers
        let navController = UINavigationController(rootViewController: tabBarController)
        // Set the tab bar controller as the root view controller
        self.window?.rootViewController = navController

//        navigationStackService = resolveDependency(NavigationStackServiceProtocol.self, name: "common")
//        navigationStackService?.set(navigationStack: window?.rootViewController?.navigationController)
//        navigationStackService?.set(isNavigationBarHidden: true)
        NavigationStackProvider.shared.navigationStack = window?.rootViewController as? UINavigationController
        NavigationStackProvider.shared.set(isNavigationBarHidden: true)

        // Handle initial link if any
        deeplinksService = resolveDependency(DeeplinksServiceProtocol.self)
        handleURLContext(context: connectionOptions.urlContexts)
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        handleURLContext(context: URLContexts)
    }

    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        // Handle Universal Links
    }

    func getCurrentNavigationController() -> UINavigationController? {
        return window?.rootViewController as? UINavigationController
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

// MARK: - Private Methods

private extension SceneDelegate {

    func handleURLContext(context: Set<UIOpenURLContext>) {
        deeplinksService?.context = DeeplinkProcessorContext(
            viewController: self.window?.rootViewController,
            moduleOutput: nil
        )

        if let urlContext = context.first,
           let content = DeeplinkContent(
            urlString: urlContext.url.absoluteString,
            isExternal: true
        ) {

            deeplinksService?.handleDeeplink(
                content: content,
                executeHandler: true
            )
        }
    }

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
