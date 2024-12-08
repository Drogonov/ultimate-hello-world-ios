//
//  AuthPresenter.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import SwiftUI
import DI

// MARK: - AuthPresenter

class AuthPresenter {

    // MARK: Public Properties

    weak var view: AuthViewInput?

    // MARK: Private Properties

    private weak var moduleOutput: AuthModuleOutput?

    private var router: AuthRouterInput
    private var dataStorage: AuthDataStorage?

    @ObservedObject var viewModel = AuthViewModel()

    // MARK: Services

    // MARK: Init

    init(
        router: AuthRouterInput
    ) {
        self.router = router
    }
}

// MARK: - AuthPresenterInput

extension AuthPresenter: AuthPresenterInput {
    func viewIsReady() {
        let model = AuthModel(title: dataStorage?.response)

        viewModel.navigationTitle = model.title ?? .empty
        viewModel.text = model.title ?? .empty

        self.view?.setView(with: viewModel)
    }

    func viewWillAppear() {}

    func viewWillDissapear() {}

    func viewButtonTapped() {}

    func getEmptyModel() -> AuthViewModel {
        viewModel
    }
}

// MARK: - AuthModuleInput

extension AuthPresenter: AuthModuleInput {
    func setModuleOutput(_ moduleOutput: MVPModuleOutputProtocol) {
        self.moduleOutput = moduleOutput as? AuthModuleOutput
    }

    func set(dataStorage: AuthDataStorage) {
        self.dataStorage = dataStorage
    }
}

// MARK: - AuthModuleOutput

extension AuthPresenter: AuthModuleOutput {}

// MARK: - Private Methods

fileprivate extension AuthPresenter {}

// MARK: - Constants

fileprivate extension AuthPresenter {

    // delete if not needed
    // enum Constants {}
}
