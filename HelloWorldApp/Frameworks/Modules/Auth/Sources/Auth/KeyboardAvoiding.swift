//
//  KeyboardAvoiding.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import SnapKit
import UIKit

// ----------------------------------------------------------------------------
// Parameter 'keyboardAvoiding' is unused
// periphery:ignore
public protocol KeyboardAvoidingOutput: AnyObject {
    func keyboardAvoiding(keyboardFrame: CGRect?)
}

public final class KeyboardAvoiding {
// MARK: - Construction

    public init(view: UIView, constraint: Constraint, initialOffset: CGFloat = 0, isViewNested: Bool = false) {
        // Init instance variables
        self.view = view
        self.constraint = constraint
        self.initialConstraintConstant = initialOffset
        self.isViewNested = isViewNested

        configure()
    }

    public init(view: UIView, constraint: NSLayoutConstraint, isViewNested: Bool = false) {
        // Init instance variables
        self.view = view
        self.layoutConstraint = constraint
        self.initialConstraintConstant = constraint.constant
        self.isViewNested = isViewNested

        configure()
    }

    deinit {
        // Unregister from notifications
        NotificationCenter.default.removeObserver(self)
    }

// MARK: - Properties

    public weak var output: KeyboardAvoidingOutput?

    private var safeAreaBottomInset: CGFloat {
        self.view.safeAreaInsets.bottom
    }

    private(set) var avoiding: Bool = false

// MARK: - Methods

    public func startAvoiding() {
        self.avoiding = true

        if let keyboardFrame = self.keyboardFrame {
            // Update view frame
            updateConstraint(keyboardFrame)
        }
    }

    public func endAvoiding() {
        self.avoiding = false

        // Update view frame
        updateConstraint(nil)
    }

// MARK: - Private Methods

    private func configure() {
        // Subscribe for keyboard notifications
        weak var weakSelf = self
        let notificationCenter = NotificationCenter.default

        DispatchQueue.performOnMainThread {
            notificationCenter.addObserver(self, selector: #selector(weakSelf?.handleKeyboardWillShow(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
            notificationCenter.addObserver(self, selector: #selector(weakSelf?.handleKeyboardWillHide(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    }

    @objc
    private func handleKeyboardWillShow(_ notification: Notification) {
        if let userInfo = notification.userInfo,
           let keyboardFrameEnd = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.keyboardFrame = keyboardFrameEnd

            if self.avoiding {
                let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue

                // Update view frame
                updateConstraint(keyboardFrameEnd, animationDuration: animationDuration)
                output?.keyboardAvoiding(keyboardFrame: keyboardFrameEnd)
            }
        }
    }

    @objc
    private func handleKeyboardWillHide(_ notification: Notification) {
        self.keyboardFrame = nil

        if self.avoiding {
            let animationDuration = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSNumber)?.doubleValue

            // Update view frame
            updateConstraint(nil, animationDuration: animationDuration)
            output?.keyboardAvoiding(keyboardFrame: nil)
        }
    }

    private func updateConstraint(_ keyboardFrame: CGRect?, animationDuration: TimeInterval? = 0.0) {
        // Disable animation
        let state = UIView.areAnimationsEnabled
        UIView.setAnimationsEnabled(false)

        // Force to recalculate view frame if needed (without animation)
        self.view.superview?.layoutIfNeeded()

        // Restore previous animation state
        UIView.setAnimationsEnabled(state)

        if let keyboardFrame = keyboardFrame {
            let viewFrame: CGRect
            if isViewNested {
                viewFrame = self.view.convert(
                    self.view.frame,
                    to: UIApplication.shared.windows.first { $0.isKeyWindow }
                )
            } else {
                viewFrame = self.view.frame
            }
            let intersectionFrame = keyboardFrame.intersection(viewFrame)

            // Decrease view frame
            let height = self.initialConstraintConstant + intersectionFrame.size.height - self.safeAreaBottomInset
            self.layoutConstraint?.constant = height
            self.constraint?.update(inset: height)
        } else {
            // Reset bottom constraint to initial value
            self.layoutConstraint?.constant = self.initialConstraintConstant
            self.constraint?.update(inset: self.initialConstraintConstant)
        }

        // Layout superview
        UIView.animate(withDuration: animationDuration ?? 0.0, animations: {
            self.view.superview?.layoutIfNeeded()

//            if let keyboardAvoidingScrollView = self.view.firstViewOfClass(TPKeyboardAvoidingScrollView.self) {
//                // Scroll to active text field if scroll view frame changed
//                keyboardAvoidingScrollView.scrollToActiveTextField()
//            }
        })
    }

// MARK: - Variables

    private let view: UIView

    private var layoutConstraint: NSLayoutConstraint?
    private var constraint: Constraint?

    private let initialConstraintConstant: CGFloat

    private var keyboardFrame: CGRect?
    private let isViewNested: Bool
}

// ----------------------------------------------------------------------------

