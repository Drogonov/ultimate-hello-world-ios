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

// MARK: - OnboardingPresenter

class OnboardingPresenter {

    // MARK: Public Properties

    weak var view: OnboardingViewInput?

    // MARK: Private Properties

    private weak var moduleOutput: OnboardingModuleOutput?

    private var router: OnboardingRouterInput
    private var dataStorage: OnboardingDataStorage?

    @ObservedObject var viewModel = OnboardingViewModel()

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
        let model = OnboardingModel(title: dataStorage?.response)

        viewModel.navigationTitle = model.title ?? .empty
        viewModel.text = model.title ?? .empty

        self.view?.setView(with: viewModel)
    }

    func viewWillAppear() {}

    func viewWillDissapear() {}

    func viewButtonTapped() {}

    func getEmptyModel() -> OnboardingViewModel {
        viewModel
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

fileprivate extension OnboardingPresenter {}

// MARK: - Constants

fileprivate extension OnboardingPresenter {

    // delete if not needed
    // enum Constants {}
}
