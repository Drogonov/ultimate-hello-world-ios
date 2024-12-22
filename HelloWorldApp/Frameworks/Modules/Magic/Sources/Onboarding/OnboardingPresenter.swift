//
//  OnboardingPresenter.swift
//  Magic
//
//  Created by Anton Vlezko on 11/10/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import SwiftUI
import DI
import CommonApplication

// MARK: - OnboardingPresenter

class OnboardingPresenter {

    // MARK: Public Properties

    weak var view: OnboardingViewInput?

    // MARK: Private Properties

    private weak var moduleOutput: OnboardingModuleOutput?

    private var router: OnboardingRouterInput
    private var dataStorage: OnboardingDataStorage?

    private var viewModel: OnboardingViewModel?

    // MARK: Services

    // MARK: Init

    init(
        router: OnboardingRouterInput
    ) {
        self.router = router
    }
}

// MARK: - OnboardingPresenterInput

extension OnboardingPresenter: OnboardingPresenterInput {
    func viewIsReady() {
        guard let dataStorage = dataStorage else {
            return
        }

        viewModel = getDefaultViewModel()
        viewModel?.text = dataStorage.onboardingText
        viewModel?.buttonText = dataStorage.onboardingButtonText

        if let viewModel {
            view?.setView(with: viewModel)
        }
    }

    func viewButtonTapped() {
        router.goToMainTabBar()
    }
}

// MARK: - OnboardingModuleInput

extension OnboardingPresenter: OnboardingModuleInput {
    func setModuleOutput(_ moduleOutput: MVPModuleOutputProtocol) {
        self.moduleOutput = moduleOutput as? OnboardingModuleOutput
    }

    func set(dataStorage: OnboardingDataStorage) {
        self.dataStorage = dataStorage
    }
}

// MARK: - OnboardingModuleOutput

extension OnboardingPresenter: OnboardingModuleOutput {}

// MARK: - Private Methods

fileprivate extension OnboardingPresenter {
    func getDefaultViewModel() -> OnboardingViewModel {
        OnboardingViewModel(text: .empty, buttonText: .empty)
    }
}
