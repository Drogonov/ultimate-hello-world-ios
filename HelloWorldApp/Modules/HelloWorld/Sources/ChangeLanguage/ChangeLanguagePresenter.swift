//
//  ChangeLanguagePresenter.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 10/06/2024.
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

// MARK: - ChangeLanguagePresenter

class ChangeLanguagePresenter {

    // MARK: Public Properties

    weak var view: ChangeLanguageViewInput?

    // MARK: Private Properties

    private var router: ChangeLanguageRouterInput

    private var dataStorage: ChangeLanguageDataStorage?
    private weak var moduleOutput: ChangeLanguageModuleOutput?

    private var getCountriesResponse: GetCountriesResponseMo?

    @DelayedImmutable var getCountriesService: GetCountriesNetworkServiceProtocol?
    @DelayedImmutable var languageService: LanguageChangeServiceProtocol?

    @ObservedObject var viewModel = ChangeLanguageViewModel()

    // MARK: Services

    // MARK: Init

    init(
        router: ChangeLanguageRouterInput
    ) {
        self.router = router
    }
}

// MARK: - ChangeLanguagePresenterInput

extension ChangeLanguagePresenter: ChangeLanguagePresenterInput {
    func viewIsReady() {
        let code = languageService?.getCurrentLanguage() ?? Language.english
        getCountries(languageCode: code.rawValue)
    }

    func viewWillAppear() {}

    func viewWillDissapear() {}

    func switchToggled(on index: Int) {
        guard let code = getCountriesResponse?.countries?[index].languageCode else {
            return
        }

        getCountries(languageCode: code)
    }

    func getEmptyModel() -> ChangeLanguageViewModel {
        getCountriesResponse = dataStorage?.response

        guard let response = getCountriesResponse else {
            return viewModel
        }

        let model = getModel(from: response)
        setViewModel(with: model)

        return viewModel
    }
}

// MARK: - ChangeLanguageModuleInput

extension ChangeLanguagePresenter: ChangeLanguageModuleInput {

    func setModuleOutput(_ moduleOutput: MVPModuleOutputProtocol) {
        self.moduleOutput = moduleOutput as? ChangeLanguageModuleOutput
    }

    func set(dataStorage: ChangeLanguageDataStorage) {
        self.dataStorage = dataStorage
    }
}

// MARK: - ChangeLanguageModuleOutput

extension ChangeLanguagePresenter: ChangeLanguageModuleOutput {}

// MARK: - Private Methods

fileprivate extension ChangeLanguagePresenter {
    func getCountries(languageCode: String) {
        let request = GetCountriesRequestMo(languageCode: languageCode)

        Task {
            do {
                let response = try await getCountriesService?.getCountriesData(request: request, forceRequest: false)
                handleSuccess(response: response)
            } catch {
                handleFailure(error: error.getTopLayerErrorResponse())
            }
        }
    }

    @MainActor
    func handleSuccess(response: GetCountriesResponseMo?) {
        guard let response = response else {
            return
        }

        getCountriesResponse = response
        setCurrentLanguage(from: response)

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

    func getModel(from response: GetCountriesResponseMo) -> ChangeLanguageModel {
        let languages: [LanguageModel] = response.countries?.compactMap({
            guard let title = getTitle(from: $0) else {
                return nil
            }

            return LanguageModel(
                title: title,
                isSelected: $0.isCurrent ?? false
            )
        }) ?? []

        let model = ChangeLanguageModel(
            title: response.title ?? ResourcesStrings.changeLanguageTitle(),
            languages: languages
        )

        return model
    }

    func setViewModel(with model: ChangeLanguageModel) {
        viewModel.navigationTitle = model.title
        viewModel.languages = model.languages.compactMap({
            LanguageViewModel(title: $0.title, isSelected: $0.isSelected)
        })
    }

    func getTitle(from model: CountryMo) -> String? {
        var continuatedText: String?
        if let emojiText = model.emoji {
            continuatedText = emojiText
        }

        if let text = model.languageName {
            continuatedText = continuatedText?.isNotBlank ?? false
            ? "\(continuatedText ?? .empty) \(text)"
            : text
        }

        return continuatedText
    }

    func setCurrentLanguage(from response: GetCountriesResponseMo) {
        guard let newLanguageCode = response.countries?.first(where: { $0.isCurrent ?? false })?.languageCode,
        let language = Language(rawValue: newLanguageCode) else {
            return
        }

        languageService?.setupAppWith(language: language)
    }
}

// MARK: - Constants

fileprivate extension ChangeLanguagePresenter {

    // delete if not needed
    // enum Constants {}
}
