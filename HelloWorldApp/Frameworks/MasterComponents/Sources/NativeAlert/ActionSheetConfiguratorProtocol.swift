//
//  ActionSheetConfiguratorProtocol.swift
//  MasterComponents
//
//  Created by Anton Vlezko on 27/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import UIKit
import Common

// sourcery: AutoMockable, isOpen
public protocol ActionSheetConfiguratorProtocol {
    func addAction(
        title: String,
        isDestructive: Bool,
        preferredAction: Bool,
        action: VoidBlock?
    )
    func addCancelAction(title: String, action: VoidBlock?)
    func addAction(
        title: String,
        style: UIAlertAction.Style,
        action: VoidBlock?,
        configurationBlock: ((UIAlertAction) -> Void)?
    )

    func addPreferredAction(
        title: String,
        style: UIAlertAction.Style,
        preferredAction: Bool,
        action: VoidBlock?
    )
}

public extension ActionSheetConfiguratorProtocol {

    func addAction(
        title: String,
        isDestructive: Bool = false,
        preferredAction: Bool = false,
        action: VoidBlock? = nil
    ) {
        addAction(
            title: title,
            isDestructive: isDestructive,
            preferredAction: preferredAction,
            action: action
        )
    }

    func addCancelAction(title: String, action: VoidBlock? = nil) {
        addCancelAction(title: title, action: action)
    }

    func addAction(
        title: String,
        style: UIAlertAction.Style,
        action: VoidBlock? = nil,
        configurationBlock: ((UIAlertAction) -> Void)? = nil
    ) {
        addAction(
            title: title,
            style: style,
            action: action,
            configurationBlock: configurationBlock
        )
    }
}
