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
    @ObservedObject var viewStore = AuthViewStore()

    // MARK: UI Properties

    lazy var authView: AuthView = {
        AuthView(
            store: viewStore
        )
    }()

    // MARK: Inheritance

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        presenter.viewIsReady()
    }
}

// MARK: - AuthViewInput

extension AuthViewController: AuthViewInput {

    func setView(with viewModel: AuthViewModel) {
        setNavigationBarTitle(with: viewModel.navigationTitle)
        viewStore.update(with: viewModel)
    }
}

// MARK: - ViewConfigurable

extension AuthViewController: ViewConfigurable {

    public func configureViews() {
        view.backgroundColor = .surfaceColor

        configureNavigationBar()
        viewStore.delegate = self
    }

    public func configureConstraints() {
        addMainViewToViewController(authView)
    }
}

// MARK: - AuthViewActionProtocol

extension AuthViewController: AuthViewActionProtocol {
    func viewDidChangeTextField(type: AuthTextFieldType, text: String) {
        presenter.viewDidChangeTextField(type: type, text: text)
    }
    
    func viewDidChangeAuthMode(mode: AuthMode) {
        presenter.viewDidChangeAuthMode(mode: mode)
    }
    
    func viewDidTapSubmitButton() {
        presenter.viewDidTapSubmitButton()
    }
}
