//
//  OTPViewController.swift
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

// MARK: - OTPViewController

final class OTPViewController: UIViewController, MVPModuleProtocol, BaseViewControllerProtocol {

    // MARK: Public Properties

    var moduleInput: MVPModuleInputProtocol?

    @DelayedImmutable var presenter: OTPPresenterInput

    // MARK: UI Properties

    lazy var testView: OTPView = {
        OTPView(
            model: self.presenter.getEmptyModel(),
            verifyTapped: { _ in
            },
            resendTapped: { }
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

// MARK: - OTPViewInput

extension OTPViewController: OTPViewInput {

    func setView(with viewModel: OTPViewModel) {
        setNavigationBarTitle(with: viewModel.navigationTitle)
        configureView(with: viewModel)
    }
}

// MARK: - ViewConfigurable

extension OTPViewController: ViewConfigurable {

    public func configureViews() {
        view.backgroundColor = .surfaceColor

        configureNavigationBar()
    }

    public func configureConstraints() {
        addMainViewToViewController(testView)
    }
}

// MARK: - Private Methods

fileprivate extension OTPViewController {
    private func configureView(with viewModel: OTPViewModel) {
        self.testView.model = viewModel
    }
}

// MARK: - Constants

fileprivate extension OTPViewController {

    // delete if not needed
    // enum Constants {}
}
