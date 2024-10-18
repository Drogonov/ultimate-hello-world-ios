//
//  ViewController+Extension.swift
//  Common
//
//  Created by Anton Vlezko on 12/03/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import UIKit

extension UIViewController {
    public func topViewController() -> UIViewController? {
        if let tabBarViewController = self as? UITabBarController {
            if let selectedTab = tabBarViewController.selectedViewController {
                return selectedTab.topViewController()
            } else {
                return tabBarViewController.topViewController()
            }
        } else if let navigationViewController = self as? UINavigationController {
            return navigationViewController.visibleViewController?.topViewController()
        } else if presentedViewController == nil {
            return self
        } else {
            return presentedViewController?.topViewController()
        }
    }

    public func presentedViewController() -> UIViewController? {
        if let presentedViewController = presentedViewController?.topViewController() {
            return presentedViewController
        } else if let tabBarViewController = self as? UITabBarController {
            if let selectedTab = tabBarViewController.selectedViewController {
                return selectedTab.topViewController()
            } else {
                return tabBarViewController.topViewController()
            }
        } else if let navigationViewController = self as? UINavigationController {
            return navigationViewController.visibleViewController?.topViewController()
        } else {
            return self
        }
    }
}
