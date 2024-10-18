//
//  PresentAlertProtocol.swift
//  MasterComponents
//
//  Created by Anton Vlezko on 27/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import UIKit
import Common
import CommonApplication

// MARK: - NativeAlertProtocol

public protocol PresentAlertProtocol: AnyObject {}

// MARK: - NativeAlertProtocol extension

extension PresentAlertProtocol {
    private weak var viewController: UIViewController? {
        let rootVC = NavigationStackProvider.shared.navigationStack
        let vc = rootVC?.topViewController()

        if let topViewController = rootVC?.topViewController,
           vc?.isBeingDismissed ?? true {
            return topViewController
        }

        return vc
    }

    // MARK: Methods

    func present(
        _ alertDialog: UIViewController,
        animated: Bool,
        completion: VoidBlock? = nil
    ) {
        viewController?.present(alertDialog, animated: animated, completion: completion)
    }
}

