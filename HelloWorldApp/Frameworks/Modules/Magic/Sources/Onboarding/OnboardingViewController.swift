//
//  OnboardingViewController.swift
//  Magic
//
//  Created by Anton Vlezko on 11/10/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import DI
import UIKit
import SnapKit
import Common
import Resources
import MasterComponents

// MARK: - OnboardingViewController

final class OnboardingViewController: UIViewController, MVPModuleProtocol, BaseViewControllerProtocol {

    // MARK: Public Properties

    var moduleInput: MVPModuleInputProtocol?

    @DelayedImmutable var presenter: OnboardingPresenterInput

    // MARK: UI Properties

    lazy var testView: OnboardingView = {
        OnboardingView(
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

// MARK: - OnboardingViewInput

extension OnboardingViewController: OnboardingViewInput {

    func setView(with viewModel: OnboardingViewModel) {
        configureView(with: viewModel)
    }
}

// MARK: - ViewConfigurable

extension OnboardingViewController: ViewConfigurable {

    public func configureViews() {
        view.backgroundColor = .surfaceColor

        configureNavigationBar()
    }

    public func configureConstraints() {
        addMainViewToViewController(testView)
    }
}

// MARK: - Private Methods

fileprivate extension OnboardingViewController {
    private func configureView(with viewModel: OnboardingViewModel) {
        self.testView.model = viewModel
    }
}

// MARK: - Constants

fileprivate extension OnboardingViewController {

    // delete if not needed
    // enum Constants {}
}
