//
//  UIApplication+Extension.swift
//  Common
//
//  Created by Anton Vlezko on 12/03/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import UIKit

public extension UIApplication {
    var currentKeyWindow: UIWindow? {
        // Get connected scenes
        return self.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }

    var currentStatusBarFrame: CGRect? {
        currentKeyWindow?.windowScene?.statusBarManager?.statusBarFrame
    }

    var topViewController: UIViewController? {
        currentKeyWindow?.rootViewController?.topViewController()
    }
}
