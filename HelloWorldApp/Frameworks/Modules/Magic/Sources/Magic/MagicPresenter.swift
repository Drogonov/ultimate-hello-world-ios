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
    private var viewModel: MagicViewModel?

    // MARK: Services

    @DelayedImmutable var appNetworkService: AppNetworkServiceProtocol?
    @DelayedImmutable var languageService: LanguageChangeServiceProtocol?

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
        viewModel = getDefaultViewModel()
        if let viewModel {
            view?.setView(with: viewModel)
        }

        let code = languageService?.getCurrentLanguage() ?? Language.english
        let request = GetMagicRequestMo(languageCode: code.rawValue)

        Task {
            do {
                let response = try await appNetworkService?.getMagicData(request: request, forceRequest: false)
                await handleSuccess(response: response)
            } catch {
                await handleFailure(error: error.getTopLayerErrorResponse())
            }
        }
    }

    func viewNavigationItemBackAction(_ completion: VoidBlock?) {
        moduleOutput?.magicNavigationItemBackAction(completion)
    }

    func viewButtonTapped() {
        // showing error alert
        let request = GetMagicRequestMo(languageCode: "error")

        Task {
            do {
                let response = try await appNetworkService?.getMagicData(request: request, forceRequest: false)
                await handleSuccess(response: response)
            } catch {
                await handleFailure(error: error.getTopLayerErrorResponse())
            }
        }
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

        viewModel?.navigationTitle = response.title ?? .empty
        viewModel?.infoText = response.infoText ?? .empty
        viewModel?.jokeText = response.jokeText ?? .empty
        viewModel?.mainText = response.mainText ?? .empty

        if let viewModel {
            view?.setView(with: viewModel)
        }
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

    func getDefaultViewModel() -> MagicViewModel {
        MagicViewModel(
            navigationTitle: .empty,
            mainText: .empty,
            jokeText: .empty,
            infoText: .empty
        )
    }
}
