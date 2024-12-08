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
            buttonTapped: {
                self.presenter.viewButtonTapped()
            }
        )
    }()

    // MARK: Inheritance

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        presenter.viewIsReady()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter.viewWillAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        presenter.viewWillAppear()
    }

    // MARK: Selectors
    // ...
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
        addMainViewToViewController(testView)
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
