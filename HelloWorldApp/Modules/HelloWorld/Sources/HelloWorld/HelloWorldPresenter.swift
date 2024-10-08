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

    @DelayedImmutable var getHelloNetworkService: GetHelloNetworkServiceProtocol?
    @DelayedImmutable var languageService: LanguageChangeServiceProtocol?

    @ObservedObject private var viewModel = HelloWorldViewModel()


    // MARK: Services

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
        let code = languageService?.getCurrentLanguage() ?? Language.english
        let request = GetHelloRequestMo(languageCode: code.rawValue)

        Task {
            do {
                let response = try await getHelloNetworkService?.getHelloData(request: request, forceRequest: false)
                handleSuccess(response: response)
            } catch {
                handleFailure(error: error.getTopLayerErrorResponse())
            }
        }
    }

    func viewWillAppear() {}

    func viewWillDissapear() {}

    func viewMoreInfoTapped() {
        let dataStorage = MoreInfoDataStorage()
        router.goToMoreInfoModule(dataStorage: dataStorage)
    }

    func getEmptyModel() -> HelloWorldViewModel {
        getHelloResponse = dataStorage?.response

        guard let response = getHelloResponse else {
            return viewModel
        }

        let model = getModel(from: response)
        setViewModel(with: model)

        return viewModel
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

        let viewModel = NativeAlertViewModel(body: body)

        showNativeAlert(viewModel: viewModel)
    }

    func getModel(from response: GetHelloResponseMo) -> HelloWorldModel {
        var continuatedText: String?
        if let emojiText = response.emoji {
            continuatedText = emojiText
        }

        if let text = response.text {
            continuatedText = continuatedText?.isNotBlank ?? false
            ? "\(continuatedText ?? .empty) \(text)"
            : text
        }

        let model = HelloWorldModel(
            title: ResourcesStrings.helloWorldTitle(),
            buttonTitle: response.buttonTitle ?? ResourcesStrings.helloWorldButtonTitle(),
            text: continuatedText ?? ResourcesStrings.helloWorldText()
        )

        return model
    }

    func setViewModel(with model: HelloWorldModel) {
        viewModel.navigationTitle = model.title
        viewModel.buttonTitle = model.buttonTitle
        viewModel.text = model.text
    }
}

// MARK: - Constants

fileprivate extension HelloWorldPresenter {

    // delete if not needed
    // enum Constants {}
}
