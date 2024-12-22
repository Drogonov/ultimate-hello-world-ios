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
    private var viewModel: MoreInfoViewModel?

    // MARK: Services

    @DelayedImmutable var appNetworkService: AppNetworkServiceProtocol?
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
        viewModel = getDefaultViewModel()
        if let viewModel {
            view?.setView(with: viewModel)
        }

        let code = languageService?.getCurrentLanguage() ?? Language.english
        let request = GetMoreInfoRequestMo(languageCode: code.rawValue)

        Task {
            do {
                let response = try await appNetworkService?.getMoreInfoData(request: request, forceRequest: false)
                await handleSuccess(response: response)
            } catch {
                await handleFailure(error: error.getTopLayerErrorResponse())
            }
        }
    }

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

        viewModel?.navigationTitle = response.title ?? .empty

        if let urlStr = response.imageUrl,
           let imageUrl = URL(string: urlStr) {
            viewModel?.imageUrl = imageUrl
        }
        viewModel?.text = response.text ?? .empty
        viewModel?.buttonTitle = response.buttonTitle ?? .empty

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

    func getDefaultViewModel() -> MoreInfoViewModel {
        MoreInfoViewModel(
            navigationTitle: .empty,
            imageUrl: nil,
            text: .empty,
            buttonTitle: .empty
        )
    }
}
