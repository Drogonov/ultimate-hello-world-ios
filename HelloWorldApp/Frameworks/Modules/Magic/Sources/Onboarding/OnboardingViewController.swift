//
//  OnboardingViewController.swift
//  Magic
//
//  Created by Anton Vlezko on 11/10/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import DI
import UIKit
import SwiftUI
import SnapKit
import Common
import Resources
import MasterComponents

// MARK: - OnboardingViewController

final class OnboardingViewController: UIViewController, MVPModuleProtocol, BaseViewControllerProtocol {

    // MARK: Public Properties

    var moduleInput: MVPModuleInputProtocol?

    @DelayedImmutable var presenter: OnboardingPresenterInput
    @ObservedObject var viewStore = OnboardingViewStore()

    // MARK: UI Properties

    lazy var onboardingView: OnboardingView = {
        OnboardingView(store: viewStore)
    }()

    // MARK: Inheritance

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        presenter.viewIsReady()
    }
}

// MARK: - OnboardingViewInput

extension OnboardingViewController: OnboardingViewInput {
    func setView(with viewModel: OnboardingViewModel) {
        viewStore.update(with: viewModel)
    }
}

// MARK: - ViewConfigurable

extension OnboardingViewController: ViewConfigurable {

    public func configureViews() {
        view.backgroundColor = .surfaceColor

        configureNavigationBar()
        viewStore.delegate = self
    }

    public func configureConstraints() {
        addMainViewToViewController(onboardingView)
    }
}

// MARK: - OnboardingViewActionProtocol

extension OnboardingViewController: OnboardingViewActionProtocol {
    func viewButtonTapped() {
        presenter.viewButtonTapped()
    }
}
