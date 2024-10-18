//
//  MoreInfoPresenter.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 16/06/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import SwiftUI
import DI
import Common
import MasterComponents
import Resources
import Services
import Net
import CommonApplication
import CommonNet

// MARK: - MoreInfoPresenter

class MoreInfoPresenter {

    // MARK: Public Properties

    weak var view: MoreInfoViewInput?

    // MARK: Private Properties

    private weak var moduleOutput: MoreInfoModuleOutput?

    private var router: MoreInfoRouterInput
    private var dataStorage: MoreInfoDataStorage?
    private var getMoreInfoResponse: GetMoreInfoResponseMo?

    @ObservedObject var viewModel = MoreInfoViewModel()

    // MARK: Services

    @DelayedImmutable var getMoreInfoNetworkService: GetMoreInfoNetworkServiceProtocol?
    @DelayedImmutable var languageService: LanguageChangeServiceProtocol?
    @DelayedImmutable var deeplinksService: DeeplinksServiceProtocol?

    // MARK: Init

    init(
        router: MoreInfoRouterInput
    ) {
        self.router = router
    }
}

// MARK: - MoreInfoPresenterInput

extension MoreInfoPresenter: MoreInfoPresenterInput {
    func viewIsReady() {
        guard dataStorage?.response.isNone ?? true else {
            return
        }

        let code = languageService?.getCurrentLanguage() ?? Language.english
        let request = GetMoreInfoRequestMo(languageCode: code.rawValue)

        Task {
            do {
                let response = try await getMoreInfoNetworkService?.getMoreInfoData(request: request, forceRequest: false)
                handleSuccess(response: response)
            } catch {
                handleFailure(error: error.getTopLayerErrorResponse())
            }
        }
    }

    func viewWillAppear() {}

    func viewWillDissapear() {}

    func viewButtonTapped() {
        guard let urlString = getMoreInfoResponse?.deeplink?.absoluteString,
              let content = DeeplinkContent(
            urlString: urlString,
            isExternal: false
        ) else {
            router.goToMagicScreen(dataStorage: MagicDataStorage())
            return
        }

        deeplinksService?.handleDeeplink(content: content, executeHandler: true)
    }

    func getEmptyModel() -> MoreInfoViewModel {
        getMoreInfoResponse = dataStorage?.response

        guard let response = getMoreInfoResponse else {
            return viewModel
        }

        let model = getModel(from: response)
        setViewModel(with: model)

        return viewModel
    }
}

// MARK: - MoreInfoModuleInput

extension MoreInfoPresenter: MoreInfoModuleInput {

    func setModuleOutput(_ moduleOutput: MVPModuleOutputProtocol) {
        self.moduleOutput = moduleOutput as? MoreInfoModuleOutput
    }

    func set(dataStorage: MoreInfoDataStorage) {
        self.dataStorage = dataStorage
    }
}

// MARK: - MoreInfoModuleOutput

extension MoreInfoPresenter: MoreInfoModuleOutput {}

// MARK: - Private Methods

fileprivate extension MoreInfoPresenter {
    @MainActor
    func handleSuccess(response: GetMoreInfoResponseMo?) {
        guard let response = response else {
            return
        }

        getMoreInfoResponse = response

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
            title: error.errorCodeValue,
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

    func getModel(from response: GetMoreInfoResponseMo) -> MoreInfoModel {
        let model = MoreInfoModel(
            title: response.title ?? .empty,
            imageUrl: response.imageUrl ?? .empty,
            text: response.text ?? .empty,
            buttonTitle: response.buttonTitle ?? .empty
        )

        return model
    }

    func setViewModel(with model: MoreInfoModel) {
        viewModel.navigationTitle = model.title
        if let imageUrl = URL(string: model.imageUrl) {
            viewModel.imageUrl = imageUrl
        }
        viewModel.text = model.text
        viewModel.buttonTitle = model.buttonTitle
    }
}

// MARK: - Constants

fileprivate extension MoreInfoPresenter {

    // delete if not needed
    // enum Constants {}
}
