//
//  MagicPresenter.swift
//  Magic
//
//  Created by Anton Vlezko on 16/06/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import DI
import SwiftUI
import Common
import MasterComponents
import Services
import Net
import CommonApplication
import CommonNet
import Resources

// MARK: - MagicPresenter

class MagicPresenter {

    // MARK: Public Properties

    weak var view: MagicViewInput?

    // MARK: Private Properties

    private var router: MagicRouterInput

    private var dataStorage: MagicDataStorage?
    private weak var moduleOutput: MagicModuleOutput?

    private var getMagicResponse: GetMagicResponseMo?

    @DelayedImmutable var appNetworkService: AppNetworkServiceProtocol?
    @DelayedImmutable var languageService: LanguageChangeServiceProtocol?

    @ObservedObject var viewModel = MagicViewModel()

    // MARK: Services

    // MARK: Init

    init(
        router: MagicRouterInput
    ) {
        self.router = router
    }
}

// MARK: - MagicPresenterInput

extension MagicPresenter: MagicPresenterInput {
    func viewIsReady() {
        let code = languageService?.getCurrentLanguage() ?? Language.english
        let request = GetMagicRequestMo(languageCode: code.rawValue)

        Task {
            do {
                let response = try await appNetworkService?.getMagicData(request: request, forceRequest: false)
                handleSuccess(response: response)
            } catch {
                handleFailure(error: error.getTopLayerErrorResponse())
            }
        }
    }

    func viewWillAppear() {}

    func viewWillDissapear() {}

    func viewNavigationItemBackAction(_ completion: VoidBlock?) {
        moduleOutput?.magicNavigationItemBackAction(completion)
    }

    func viewButtonTapped() {
        // showing error alert
        let request = GetMagicRequestMo(languageCode: "error")

        Task {
            do {
                let response = try await appNetworkService?.getMagicData(request: request, forceRequest: false)
                handleSuccess(response: response)
            } catch {
                handleFailure(error: error.getTopLayerErrorResponse())
            }
        }
    }

    func getEmptyModel() -> MagicViewModel {
        getMagicResponse = dataStorage?.response

        guard let response = getMagicResponse else {
            return viewModel
        }

        let model = getModel(from: response)
        setViewModel(with: model)

        return viewModel
    }
}

// MARK: - MagicModuleInput

extension MagicPresenter: MagicModuleInput {

    func setModuleOutput(_ moduleOutput: MVPModuleOutputProtocol) {
        self.moduleOutput = moduleOutput as? MagicModuleOutput
    }

    func set(dataStorage: MagicDataStorage) {
        self.dataStorage = dataStorage
    }
}

// MARK: - Private Methods

fileprivate extension MagicPresenter {
    @MainActor
    func handleSuccess(response: GetMagicResponseMo?) {
        guard let response = response else {
            return
        }

        getMagicResponse = response

        let model = getModel(from: response)
        setViewModel(with: model)

        self.view?.setView(with: viewModel)
    }

    @MainActor
    func handleFailure(error: ErrorResponseMo?) {
        guard let error = error else {
            return
        }

        let body = NativeAlertViewModel.Body(
            title: error.errorSubCodeValue,
            message: error.errorMsg
        )

        let buttons = NativeAlertViewModel.Buttons(
            firstTitle: ResourcesStrings.ok(),
            firstAction: {}
        )

        let viewModel = NativeAlertViewModel(
            body: body,
            buttons: buttons
        )

        showNativeAlert(viewModel: viewModel)
    }

    func getModel(from response: GetMagicResponseMo) -> MagicModel {
        let model = MagicModel(
            title: response.title,
            mainText: response.mainText,
            jokeText: response.jokeText,
            infoText: response.infoText
        )

        return model
    }

    func setViewModel(with model: MagicModel) {
        viewModel.navigationTitle = model.title ?? .empty
        viewModel.mainText = model.mainText ?? .empty
        viewModel.jokeText = model.jokeText ?? .empty
        viewModel.infoText = model.infoText ?? .empty
    }
}

// MARK: - Constants

fileprivate extension MagicPresenter {

    // delete if not needed
    // enum Constants {}
}
