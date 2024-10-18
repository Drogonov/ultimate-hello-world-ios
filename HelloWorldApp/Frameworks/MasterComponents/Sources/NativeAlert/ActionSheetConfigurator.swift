//
//  ActionSheetConfigurator.swift
//  MasterComponents
//
//  Created by Anton Vlezko on 27/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import UIKit
import Common

// MARK: - ActionSheetConfigurator

class ActionSheetConfigurator {

    // MARK: Private Properties

    private weak var alertController: UIAlertController?

    // MARK: Init

    init(alertController: UIAlertController) {
        self.alertController = alertController
    }
}

// MARK: - ActionSheetConfiguratorProtocol

extension ActionSheetConfigurator: ActionSheetConfiguratorProtocol {

    public func addAction(title: String, isDestructive: Bool, preferredAction: Bool, action: VoidBlock?) {
        let alertAction = UIAlertAction(title: title, style: isDestructive ? .destructive : .default, handler: { _ in
            action?()
        })

        alertController?.addAction(alertAction)

        if preferredAction {
            alertController?.preferredAction = alertAction
        }
    }

    public func addCancelAction(title: String, action: VoidBlock? = nil) {
        alertController?.addAction(
            UIAlertAction(
                title: title, style: .cancel, handler: { _ in
                    action?()
                }
            )
        )
    }

    public func addAction(
        title: String,
        style: UIAlertAction.Style,
        action: VoidBlock?,
        configurationBlock: ((UIAlertAction) -> Void)?
    ) {
        let alertAction = UIAlertAction(
            title: title,
            style: style,
            handler: { _ in
                action?()
            }
        )
        configurationBlock?(alertAction)
        alertController?.addAction(alertAction)
    }

    public func addPreferredAction(
        title: String,
        style: UIAlertAction.Style,
        preferredAction: Bool,
        action: VoidBlock?
    ) {
        let alertAction = UIAlertAction(
            title: title,
            style: style,
            handler: { _ in
                action?()
            }
        )
        alertController?.addAction(alertAction)

        if preferredAction {
            alertController?.preferredAction = alertAction
        }
    }
}

