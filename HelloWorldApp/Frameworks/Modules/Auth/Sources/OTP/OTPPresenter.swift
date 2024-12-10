//
//  OTPPresenter.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import SwiftUI
import DI
import CommonApplication

// MARK: - OTPPresenter

class OTPPresenter {

    // MARK: Public Properties

    weak var view: OTPViewInput?

    // MARK: Private Properties

    private weak var moduleOutput: OTPModuleOutput?

    private var router: OTPRouterInput
    private var dataStorage: OTPDataStorage?

    @ObservedObject var viewModel = OTPViewModel()

    // MARK: Services

    // MARK: Init

    init(
        router: OTPRouterInput
    ) {
        self.router = router
    }
}

// MARK: - OTPPresenterInput

extension OTPPresenter: OTPPresenterInput {
    func viewIsReady() {
        let model = OTPModel(title: dataStorage?.email)

        viewModel.navigationTitle = model.title ?? .empty
        viewModel.text = model.title ?? .empty

        self.view?.setView(with: viewModel)
    }

    func viewWillAppear() {}

    func viewWillDissapear() {}

    func viewButtonTapped() {}

    func getEmptyModel() -> OTPViewModel {
        viewModel
    }
}

// MARK: - OTPModuleInput

extension OTPPresenter: OTPModuleInput {    
    func set(dataStorage: OTPDataStorage) {
        self.dataStorage = dataStorage
    }
    
    func setModuleOutput(_ moduleOutput: MVPModuleOutputProtocol) {
        self.moduleOutput = moduleOutput as? OTPModuleOutput
    }
}

// MARK: - OTPModuleOutput

extension OTPPresenter: OTPModuleOutput {}

// MARK: - Private Methods

fileprivate extension OTPPresenter {}

// MARK: - Constants

fileprivate extension OTPPresenter {

    // delete if not needed
    // enum Constants {}
}
