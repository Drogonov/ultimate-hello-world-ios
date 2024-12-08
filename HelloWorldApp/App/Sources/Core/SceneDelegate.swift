//
//  SceneDelegate.swift
//  App
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
import Resources

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: Properties

    var window: UIWindow?
    var deeplinksService: DeeplinksServiceProtocol?
    var mainCoordinator: MainCoordinator?

    // MARK: Methods

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: scene)
        window?.makeKeyAndVisible()

        if let window = window {
            mainCoordinator = MainCoordinator(window: window)
            mainCoordinator?.start()
        }

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
}
