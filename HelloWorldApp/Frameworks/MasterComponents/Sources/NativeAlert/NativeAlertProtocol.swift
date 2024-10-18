//
//  NativeAlertProtocol.swift
//  MasterComponents
//
//  Created by Anton Vlezko on 27/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import UIKit
import Common

// MARK: - NativeAlertProtocol

// sourcery: AutoMockable, isOpen
public protocol NativeAlertProtocol: PresentAlertProtocol {

    func showNativeAlert(viewModel alert: NativeAlertViewModel)
    func showNativeAlert(
        with alert: NativeAlertViewModel,
        buttonsConfiguration: ((ActionSheetConfiguratorProtocol) -> Void)?
    )
}

// MARK: - NativeAlertProtocol extension

public extension NativeAlertProtocol {

    func showNativeAlert(viewModel alert: NativeAlertViewModel) {
        let config: ((ActionSheetConfiguratorProtocol) -> Void)
        switch alert.style {
        case .alert:

            guard let buttons = alert.buttons else {
                return
            }
            config = configuration(alert: buttons)

        case .actionSheet:
            guard let buttons = alert.buttons else {
                return
            }
            config = configuration(actionSheet: buttons)
        @unknown default:
            config = { _ in }
        }

        showNativeAlert(with: alert, buttonsConfiguration: config)
    }

    func showNativeAlert(
        with alert: NativeAlertViewModel,
        buttonsConfiguration: ((ActionSheetConfiguratorProtocol) -> Void)?
    ) {
        let body: NativeAlertViewModel.Body = alert.body
        var title: String? = body.title

        /// When there is a message with `nil` title it uses bold font weight for display. Use empty title to fix it
        if !body.message.isNone, title.isNone {
            title = .empty
        }

        let actionSheet = UIAlertController(
            title: title,
            message: body.message,
            preferredStyle: alert.style
        )
        let builder = ActionSheetConfigurator(alertController: actionSheet)
        buttonsConfiguration?(builder)
        actionSheet.actions.changeTitleTextColor(body.tintColor)
        present(actionSheet, animated: true)
    }
}

// MARK: - Private

fileprivate extension NativeAlertProtocol {

    func configuration(alert buttons: NativeAlertViewModel.Buttons) -> ((ActionSheetConfiguratorProtocol) -> Void) {
        let configuration: ((ActionSheetConfiguratorProtocol) -> Void) = { builder in
            let hasSecondButton = (buttons.secondTitle != nil)
            let defultFirstButtonType: UIAlertAction.Style = hasSecondButton ? .cancel : .default

            builder.addPreferredAction(
                title: buttons.firstTitle,
                style: buttons.firstStyle ?? defultFirstButtonType,
                preferredAction: !hasSecondButton,
                action: buttons.firstAction
            )

            if let title = buttons.secondTitle {

                builder.addPreferredAction(
                    title: title,
                    style: .default,
                    preferredAction: true,
                    action: buttons.secondAction
                )
            }
        }
        return configuration
    }

    func configuration(actionSheet buttons: NativeAlertViewModel.Buttons) -> ((ActionSheetConfiguratorProtocol) -> Void) {
        let configuration: ((ActionSheetConfiguratorProtocol) -> Void) = { builder in
            builder.addAction(
                title: buttons.firstTitle,
                style: buttons.firstStyle ?? .default,
                action: buttons.firstAction
            )

            if let title = buttons.secondTitle, title.isNotBlank {
                builder.addAction(
                    title: title,
                    style: .cancel,
                    action: buttons.secondAction
                )
            }
        }
        return configuration
    }

    // MARK: Properties
}

