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
    private var viewModel: ChangeLanguageViewModel?
    private var getCountriesResponse: GetCountriesResponseMo?

    // MARK: Services

    @DelayedImmutable var appNetworkService: AppNetworkServiceProtocol?
    @DelayedImmutable var authNetworkService: AuthNetworkServiceProtocol?
    @DelayedImmutable var languageService: LanguageChangeServiceProtocol?

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
        viewModel = getDefaultViewModel()
        if let viewModel {
            view?.setView(with: viewModel)
        }

        let code = languageService?.getCurrentLanguage() ?? Language.english
        getCountries(languageCode: code.rawValue)
    }

    func switchToggled(on index: Int) {
        guard let code = getCountriesResponse?.countries?[index].languageCode else {
            return
        }

        getCountries(languageCode: code)
    }

    func viewButtonTapped() {
        logout()
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
                let response = try await appNetworkService?.getCountriesData(request: request, forceRequest: false)
                await handleSuccess(response: response)
            } catch {
                await handleFailure(error: error.getTopLayerErrorResponse())
            }
        }
    }

    func logout() {
        Task {
            _ = try? await authNetworkService?.logoutData(forceRequest: false)

            KeychainJWTProvider.shared.deleteToken(.accessToken)
            KeychainJWTProvider.shared.deleteToken(.refreshToken)
            router.gotToAuth()
        }
    }

    @MainActor
    func handleSuccess(response: GetCountriesResponseMo?) {
        guard let response = response else {
            return
        }

        getCountriesResponse = response
        setCurrentLanguage(from: response)

        let languages: [LanguageViewModel] = response.countries?.compactMap({
            guard let title = getTitle(from: $0) else {
                return nil
            }

            return LanguageViewModel(
                title: title,
                isSelected: $0.isCurrent ?? false
            )
        }) ?? []

        viewModel?.navigationTitle = response.title ?? .empty
        viewModel?.languages = languages
        viewModel?.buttonText = "Logout"

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

    func getDefaultViewModel() -> ChangeLanguageViewModel {
        ChangeLanguageViewModel(
            navigationTitle: .empty,
            languages: [],
            buttonText: .empty,
            isButtonLoading: false,
            isButtonEnabled: false
        )
    }
}
