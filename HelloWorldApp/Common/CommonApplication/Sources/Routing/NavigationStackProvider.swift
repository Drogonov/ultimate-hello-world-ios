//
//  NavigationStackProvider.swift
//  CommonApplication
//
//  Created by Anton Vlezko on 30/09/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import UIKit

public class NavigationStackProvider {
    static public let shared = NavigationStackProvider()

    public var navigationStack: UINavigationController?

    private init() {}

    public func set(isNavigationBarHidden: Bool) {
        navigationStack?.isNavigationBarHidden = isNavigationBarHidden
    }

    // Method to clear the navigation stack and set a new root view controller
    public func setNewRootViewController(_ newRootViewController: UIViewController, animated: Bool = true) {
        // Check if the navigation stack exists
        if let navigationStack = navigationStack {
            // Set the new root view controller, replacing the current stack
            navigationStack.setViewControllers([newRootViewController], animated: animated)
        } else {
            // Handle the case where navigationStack might be nil
            // For example, by initializing a new UINavigationController
            let newNavigationStack = UINavigationController(rootViewController: newRootViewController)
            newNavigationStack.isNavigationBarHidden = self.navigationStack?.isNavigationBarHidden ?? false
            self.navigationStack = newNavigationStack
        }
    }
}

// # TODO: Implement service instead of singltone
/// Service doesnt work because you cant get only one instance of it. It means that you have problem in code try to find it

public protocol NavigationStackServiceProtocol {
    func set(navigationStack: UINavigationController?)
    func getNavigationStack() -> UINavigationController?
    func set(isNavigationBarHidden: Bool)
}

public final class NavigationStackService: NavigationStackServiceProtocol {

    private var navigationStack: UINavigationController?

    public init() {}

    public func set(navigationStack: UINavigationController?) {
        self.navigationStack = navigationStack
    }

    public func getNavigationStack() -> UINavigationController? {
        navigationStack
    }

    public func set(isNavigationBarHidden: Bool) {
        navigationStack?.isNavigationBarHidden = isNavigationBarHidden
    }
}
