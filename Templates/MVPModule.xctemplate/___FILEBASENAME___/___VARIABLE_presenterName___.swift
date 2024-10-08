//
//  ___VARIABLE_presenterName___.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import SwiftUI
import DI

// MARK: - ___VARIABLE_productName___Presenter

class ___VARIABLE_productName___Presenter {

    // MARK: Public Properties

    weak var view: ___VARIABLE_productName___ViewInput?

    // MARK: Private Properties

    private weak var moduleOutput: ___VARIABLE_productName___ModuleOutput?

    private var router: ___VARIABLE_productName___RouterInput
    private var dataStorage: ___VARIABLE_productName___DataStorage?

    @ObservedObject var viewModel = ___VARIABLE_productName___ViewModel()

    // MARK: Services

    // MARK: Init

    init(
        router: ___VARIABLE_productName___RouterInput
    ) {
        self.router = router
    }
}

// MARK: - ___VARIABLE_productName___PresenterInput

extension ___VARIABLE_productName___Presenter: ___VARIABLE_productName___PresenterInput {
    func viewIsReady() {
        let model = ___VARIABLE_productName___Model(title: dataStorage?.response)

        viewModel.navigationTitle = model.title ?? .empty
        viewModel.text = model.title ?? .empty

        self.view?.setView(with: viewModel)
    }

    func viewWillAppear() {}

    func viewWillDissapear() {}

    func viewButtonTapped() {}

    func getEmptyModel() -> ___VARIABLE_productName___ViewModel {
        viewModel
    }
}

// MARK: - ___VARIABLE_productName___ModuleInput

extension ___VARIABLE_productName___Presenter: ___VARIABLE_productName___ModuleInput {
    func setModuleOutput(_ moduleOutput: MVPModuleOutputProtocol) {
        self.moduleOutput = moduleOutput as? ___VARIABLE_productName___ModuleOutput
    }

    func set(dataStorage: ___VARIABLE_productName___DataStorage) {
        self.dataStorage = dataStorage
    }
}

// MARK: - ___VARIABLE_productName___ModuleOutput

extension ___VARIABLE_productName___Presenter: ___VARIABLE_productName___ModuleOutput {}

// MARK: - Private Methods

fileprivate extension ___VARIABLE_productName___Presenter {}

// MARK: - Constants

fileprivate extension ___VARIABLE_productName___Presenter {

    // delete if not needed
    // enum Constants {}
}
