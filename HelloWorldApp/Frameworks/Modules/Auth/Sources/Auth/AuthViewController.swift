//
//  AuthViewController.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import DI
import UIKit
import SnapKit
import Common
import MasterComponents
import SwiftUI

// MARK: - AuthViewController

final class AuthViewController: UIViewController, MVPModuleProtocol, BaseViewControllerProtocol {

    // MARK: Public Properties

    var moduleInput: MVPModuleInputProtocol?

    @DelayedImmutable var presenter: AuthPresenterInput

    // MARK: UI Properties

    lazy var testView: AuthView = {
        AuthView(
            model: self.presenter.getEmptyModel(),
            buttonTapped: { _ in
                self.presenter.viewButtonTapped()
            }
        )
    }()

    lazy var hostingController = UIHostingController(rootView: testView)

    private var keyboardAvoiding: KeyboardAvoiding!
    var bottomConstraint: Constraint!

    // MARK: Inheritance

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
//        configureKeyboard()
        presenter.viewIsReady()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter.viewWillAppear()
        keyboardAvoiding.startAvoiding()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        presenter.viewWillAppear()
        keyboardAvoiding.endAvoiding()
    }

    // MARK: Selectors
    // ...

    private var keyboardHeight: CGFloat = 0

    func addMainViewToViewController() {
        addChild(hostingController)

        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)

        hostingController.view.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            bottomConstraint = $0.bottom.equalToSuperview().constraint
        }

        keyboardAvoiding = KeyboardAvoiding(view: hostingController.view, constraint: bottomConstraint)
    }

//    private func configureKeyboard() {
//        self.hideKeyboardWhenTappedAround()
//        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
//    }
//
//    @objc func Keyboard(notification: Notification) {
//        if notification.name == UIResponder.keyboardWillHideNotification {
//            animateWithKeyboard(notification: notification as NSNotification) { (keyboardFrame) in
//                self.bottomConstraint?.update(offset: 0)
////                self.textInputBottomConstraint?.constant = 0
//                self.view.layoutIfNeeded()
//            }
//        } else {
//            animateWithKeyboard(notification: notification as NSNotification) { (keyboardFrame) in
//                self.bottomConstraint?.update(offset: -keyboardFrame.height)
////                self.textInputBottomConstraint?.constant = -keyboardFrame.height
//                self.view.layoutIfNeeded()
//            }
//        }
//    }



//    func enableKeyboardHandling() {
//        NotificationCenter.default.addObserver(
//            forName: UIResponder.keyboardWillShowNotification,
//            object: nil,
//            queue: .main
//        ) { [weak self] notification in
//            animateWithKeyboard(notification: <#T##NSNotification#>, animations: <#T##((CGRect) -> Void)?##((CGRect) -> Void)?##(_ keyboardFrame: CGRect) -> Void#>)
//            self?.adjustForKeyboard(notification: notification, willShow: true)
//        }
//
//        NotificationCenter.default.addObserver(
//            forName: UIResponder.keyboardWillHideNotification,
//            object: nil,
//            queue: .main
//        ) { [weak self] notification in
//            self?.adjustForKeyboard(notification: notification, willShow: false)
//        }
//    }

//    private func adjustForKeyboard(notification: Notification, willShow: Bool) {
//        guard let userInfo = notification.userInfo,
//              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
//              let safeAreaHeight = view.window?.safeAreaInsets.bottom else { return }
//
//        let offset = willShow ? (keyboardFrame.height - safeAreaHeight) / 2 : 0
//
//        UIView.animate(withDuration: 0.3) {
//            self.hostingController.view.transform = CGAffineTransform(translationX: 0, y: -offset)
//        }
//    }

//    private func setupKeyboardObservers() {
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(keyboardWillShow(_:)),
//            name: UIResponder.keyboardWillShowNotification,
//            object: nil
//        )
//
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(keyboardWillHide(_:)),
//            name: UIResponder.keyboardWillHideNotification,
//            object: nil
//        )
//    }

//    @objc private func keyboardWillShow(_ notification: Notification) {
//        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
//        keyboardHeight = keyboardFrame.height
//
//        // Adjust hosting controller view
//        hostingController.view.subviews.first?.snp.updateConstraints { make in
//            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0))
//        }
//
//        UIView.animate(withDuration: 0.3) {
//            self.hostingController.view.layoutIfNeeded()
//        }
//    }
//
//    @objc private func keyboardWillHide(_ notification: Notification) {
//        keyboardHeight = 0
//
//        // Reset hosting controller view
//        hostingController.view.subviews.first?.snp.updateConstraints { make in
//            make.edges.equalToSuperview()
//        }
//
//        UIView.animate(withDuration: 0.3) {
//            self.hostingController.view.layoutIfNeeded()
//        }
//    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - AuthViewInput

extension AuthViewController: AuthViewInput {

    func setView(with viewModel: AuthViewModel) {
        setNavigationBarTitle(with: viewModel.navigationTitle)
        configureView(with: viewModel)
    }
}

// MARK: - ViewConfigurable

extension AuthViewController: ViewConfigurable {

    public func configureViews() {
        view.backgroundColor = .surfaceColor

        configureNavigationBar()
    }

    public func configureConstraints() {
        addMainViewToViewController()
//        addMainViewToViewController(testView)
    }
}

// MARK: - Private Methods

fileprivate extension AuthViewController {
    func configureView(with viewModel: AuthViewModel) {
        self.testView.model = viewModel
    }
}

// MARK: - Constants

fileprivate extension AuthViewController {

    // delete if not needed
    // enum Constants {}
}
//
//extension UIViewController {
//    func hideKeyboardWhenTappedAround() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
//
//    func animateWithKeyboard(
//        notification: NSNotification,
//        animations: ((_ keyboardFrame: CGRect) -> Void)?) {
//            // Extract the duration of the keyboard animation
//            let durationKey = UIResponder.keyboardAnimationDurationUserInfoKey
//            let duration = notification.userInfo![durationKey] as! Double
//
//            // Extract the final frame of the keyboard
//            let frameKey = UIResponder.keyboardFrameEndUserInfoKey
//            let keyboardFrameValue = notification.userInfo![frameKey] as! NSValue
//
//            // Extract the curve of the iOS keyboard animation
//            let curveKey = UIResponder.keyboardAnimationCurveUserInfoKey
//            let curveValue = notification.userInfo![curveKey] as! Int
//            let curve = UIView.AnimationCurve(rawValue: curveValue)!
//
//            // Create a property animator to manage the animation
//            let animator = UIViewPropertyAnimator(
//                duration: duration,
//                curve: curve
//            ) {
//                // Perform the necessary animation layout updates
//                animations?(keyboardFrameValue.cgRectValue)
//
//                // Required to trigger NSLayoutConstraint changes
//                // to animate
//                self.view?.layoutIfNeeded()
//            }
//
//            // Start the animation
//            animator.startAnimation()
//        }
//}
