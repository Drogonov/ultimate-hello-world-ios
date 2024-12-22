//
//  HelloWorldPresenter.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 12/03/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import SwiftUI
import DI
import Common
import Resources
import MasterComponents
import Services
import Net
import CommonApplication
import CommonNet

// MARK: - HelloWorldPresenter

class HelloWorldPresenter {

    // MARK: Public Properties

    weak var view: HelloWorldViewInput?

    // MARK: Private Properties

    private var router: HelloWorldRouterInput

    private var dataStorage: HelloWorldDataStorage?
    private weak var moduleOutput: HelloWorldModuleOutput?
    private var getHelloResponse: GetHelloResponseMo?
    private var viewModel: HelloWorldViewModel?

    // MARK: Services

    @DelayedImmutable var appNetworkService: AppNetworkServiceProtocol?
    @DelayedImmutable var languageService: LanguageChangeServiceProtocol?

    // MARK: Init

    init(
        router: HelloWorldRouterInput
    ) {
        self.router = router
    }
}

// MARK: - HelloWorldPresenterInput

extension HelloWorldPresenter: HelloWorldPresenterInput {

    func viewIsReady() {
        viewModel = getDefaultViewModel()
        if let viewModel {
            view?.setView(with: viewModel)
        }

        let code = languageService?.getCurrentLanguage() ?? Language.english
        let request = GetHelloRequestMo(languageCode: code.rawValue)

        Task {
            do {
                let response = try await appNetworkService?.getHelloData(request: request, forceRequest: false)
                await handleSuccess(response: response)
            } catch {
                await handleFailure(error: error.getTopLayerErrorResponse())
            }
        }
    }

    func viewMoreInfoTapped() {
        let dataStorage = MoreInfoDataStorage()
        router.goToMoreInfoModule(dataStorage: dataStorage)
    }
}

// MARK: - HelloWorldModuleInput

extension HelloWorldPresenter: HelloWorldModuleInput {

    func setModuleOutput(_ moduleOutput: MVPModuleOutputProtocol) {
        self.moduleOutput = moduleOutput as? HelloWorldModuleOutput
    }

    func set(dataStorage: HelloWorldDataStorage) {
        self.dataStorage = dataStorage
    }
}

// MARK: - HelloWorldModuleOutput

extension HelloWorldPresenter: HelloWorldModuleOutput {}

// MARK: - Private Methods

fileprivate extension HelloWorldPresenter {
    @MainActor
    func handleSuccess(response: GetHelloResponseMo?) {
        guard let response = response else {
            return
        }

        getHelloResponse = response

        var continuatedText: String?
        if let emojiText = response.emoji {
            continuatedText = emojiText
        }

        if let text = response.text {
            continuatedText = continuatedText?.isNotBlank ?? false
            ? "\(continuatedText ?? .empty) \(text)"
            : text
        }

        viewModel?.navigationTitle = ResourcesStrings.helloWorldTitle()
        viewModel?.buttonTitle = response.buttonTitle ?? ResourcesStrings.helloWorldButtonTitle()
        viewModel?.text = continuatedText ?? ResourcesStrings.helloWorldText()

        viewModel = getDefaultViewModel()
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

    func getDefaultViewModel() -> HelloWorldViewModel {
        HelloWorldViewModel(
            navigationTitle: .empty,
            buttonTitle: .empty,
            text: .empty
        )
    }
}
