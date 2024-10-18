//
//  NativeAlertViewModel.swift
//  MasterComponents
//
//  Created by Anton Vlezko on 27/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import UIKit
import Common
import Resources

public struct NativeAlertViewModel {

    public struct Body {

        public let title: String?
        public let message: String?
        public let tintColor: UIColor?

        public init(title: String? = nil, message: String? = nil, tintColor: UIColor? = .systemRed) {
            self.title = title
            self.message = message
            self.tintColor = tintColor
        }
    }

    public struct Buttons {

        public let firstTitle: String
        public let firstAction: VoidBlock?
        public let firstStyle: UIAlertAction.Style?
        public let secondTitle: String?
        public let secondAction: VoidBlock?

        public init(
            firstTitle: String,
            firstAction: VoidBlock? = nil,
            firstStyle: UIAlertAction.Style? = nil,
            secondTitle: String? = nil,
            secondAction: VoidBlock? = nil
        ) {
            self.firstTitle = firstTitle
            self.firstAction = firstAction
            self.secondTitle = secondTitle
            self.secondAction = secondAction
            self.firstStyle = firstStyle
        }
    }

    public let body: NativeAlertViewModel.Body
    public let buttons: NativeAlertViewModel.Buttons?
    public let style: UIAlertController.Style

    public init(
        body: NativeAlertViewModel.Body,
        buttons: NativeAlertViewModel.Buttons? = nil,
        style: UIAlertController.Style = .alert
    ) {
        self.body = body
        self.buttons = buttons
        self.style = style
    }
}

public extension NativeAlertViewModel {

    static func oneButtonAlert(
        title: String? = nil,
        message: String? = nil,
        buttonTitle: String,
        buttonAction: VoidBlock? = nil
    ) -> NativeAlertViewModel {
        let body = NativeAlertViewModel.Body(title: title, message: message)
        let buttons = NativeAlertViewModel.Buttons(firstTitle: buttonTitle, firstAction: buttonAction)
        return NativeAlertViewModel(body: body, buttons: buttons)
    }

    static func okAlert(
        title: String? = nil,
        message: String? = nil,
        action: VoidBlock? = nil
    ) -> NativeAlertViewModel {
        NativeAlertViewModel.oneButtonAlert(
            title: title,
            message: message,
//            buttonTitle: R.string.localizable.ok(),
            buttonTitle: "R.string.localizable.ok()",
            buttonAction: action
        )
    }

    static func clearAlert(
        title: String? = nil,
        message: String? = nil,
        action: VoidBlock? = nil
    ) -> NativeAlertViewModel {
        NativeAlertViewModel.oneButtonAlert(
            title: title,
            message: message,
//            buttonTitle: R.string.localizable.clear(),
            buttonTitle: "R.string.localizable.clear()",
            buttonAction: action
        )
    }

    static func cancelWithoutActionAlert(
        title: String? = nil,
        message: String? = nil,
        cancelTitle: String,
        secondTitle: String,
        secondAction: VoidBlock?
    ) -> NativeAlertViewModel {
        let body = NativeAlertViewModel.Body(title: title, message: message)
        let buttons = NativeAlertViewModel.Buttons(
            firstTitle: cancelTitle,
            secondTitle: secondTitle,
            secondAction: secondAction
        )
        return NativeAlertViewModel(body: body, buttons: buttons)
    }

    static func onlyBodyAlert(
        title: String? = nil,
        message: String? = nil,
        style: UIAlertController.Style = .alert
    ) -> NativeAlertViewModel {
        let body = NativeAlertViewModel.Body(title: title, message: message)
        return NativeAlertViewModel(body: body, buttons: nil, style: style)
    }

    static func fullAlert(
        title: String? = nil,
        message: String? = nil,
        firstTitle: String,
        firstAction: VoidBlock? = nil,
        secondTitle: String? = nil,
        secondAction: VoidBlock? = nil
    ) -> NativeAlertViewModel {
        let body = NativeAlertViewModel.Body(title: title, message: message)
        let buttons = NativeAlertViewModel.Buttons(
            firstTitle: firstTitle,
            firstAction: firstAction,
            secondTitle: secondTitle,
            secondAction: secondAction
        )
        return NativeAlertViewModel(body: body, buttons: buttons)
    }

    static func firstButtonOptionalAlert(
        title: String? = nil,
        message: String? = nil,
        firstTitle: String? = nil,
        firstAction: VoidBlock? = nil,
        secondTitle: String? = nil,
        secondAction: VoidBlock? = nil
    ) -> NativeAlertViewModel {
        let body = NativeAlertViewModel.Body(title: title, message: message)
        let buttons: NativeAlertViewModel.Buttons?

        if let firstTitle = firstTitle {
            buttons = NativeAlertViewModel.Buttons(
                firstTitle: firstTitle,
                firstAction: firstAction,
                secondTitle: secondTitle,
                secondAction: secondAction
            )
        } else {
            buttons = NativeAlertViewModel.Buttons(
                firstTitle: secondTitle ?? .empty,
                firstAction: secondAction
            )
        }
        return NativeAlertViewModel(body: body, buttons: buttons)
    }

    static func simpleActionSheet() -> NativeAlertViewModel {
        let body = NativeAlertViewModel.Body(title: nil, message: nil)
        return NativeAlertViewModel(body: body, style: .actionSheet)
    }

    static func cancelEditAlert(
        title: String? = nil,
        message: String? = nil,
        action: VoidBlock?
    ) -> NativeAlertViewModel {
        let body = NativeAlertViewModel.Body(title: title, message: message)
        let buttons = NativeAlertViewModel.Buttons(
            firstTitle: "R.string.localizable.cancel()",
            secondTitle: "R.string.localizable.change()",
            secondAction: action
        )
        return NativeAlertViewModel(body: body, buttons: buttons)
    }
}
