//
//  AuthPresenter.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import SwiftUI
import DI
import Services
import CommonNet
import Net
import MasterComponents
import Resources

// MARK: - AuthPresenter

class AuthPresenter {

    // MARK: Public Properties

    weak var view: AuthViewInput?

    // MARK: Private Properties

    private weak var moduleOutput: AuthModuleOutput?

    private var router: AuthRouterInput
    private var dataStorage: AuthDataStorage?

    @DelayedImmutable var singInNetworkService: SingInNetworkServiceProtocol?
    @DelayedImmutable var singUpNetworkService: SingUpNetworkServiceProtocol?

    @ObservedObject var viewModel = AuthViewModel()

    // MARK: Services

    // MARK: Init

    init(
        router: AuthRouterInput
    ) {
        self.router = router
    }
}

// MARK: - AuthPresenterInput

extension AuthPresenter: AuthPresenterInput {
    func viewIsReady() {
        let model = AuthModel(
            title: "Auth",
            loginPlaceholder: "Login",
            registerPlaceholder: "Register",
            emailPlaceholder: "Email",
            passwordPlaceholder: "Password",
            confirmPasswordPlaceholder: "Confirm Password",
            buttonText: "Login"
        )

        viewModel.navigationTitle = model.title ?? .empty
        viewModel.authMode = .login

        viewModel.loginPlaceholder = model.loginPlaceholder ?? .empty
        viewModel.registerPlaceholder = model.registerPlaceholder ?? .empty

        viewModel.emailPlaceholder = model.emailPlaceholder ?? .empty
        viewModel.passwordPlaceholder = model.passwordPlaceholder ?? .empty
        viewModel.confirmPasswordPlaceholder = model.confirmPasswordPlaceholder ?? .empty

        viewModel.buttonText = model.buttonText ?? .empty

        self.view?.setView(with: viewModel)
    }

    func viewWillAppear() {}

    func viewWillDissapear() {}

    func viewButtonTapped() {
        guard viewModel.email.isNotEmpty,
              viewModel.password.isNotEmpty else {
            return
        }

        let request = SingInRequestMo(email: viewModel.email.lowercased(), password: viewModel.password)

        Task {
            do {
                let response = try await singInNetworkService?.singInData(request: request, forceRequest: false)
                handleSuccess(response: response)
            } catch {
                handleFailure(error: error.getTopLayerErrorResponse())
            }
        }
    }

    func getEmptyModel() -> AuthViewModel {
        viewModel
    }
}

// MARK: - AuthModuleInput

extension AuthPresenter: AuthModuleInput {
    func setModuleOutput(_ moduleOutput: MVPModuleOutputProtocol) {
        self.moduleOutput = moduleOutput as? AuthModuleOutput
    }

    func set(dataStorage: AuthDataStorage) {
        self.dataStorage = dataStorage
    }
}

// MARK: - AuthModuleOutput

extension AuthPresenter: AuthModuleOutput {}

// MARK: - Private Methods

fileprivate extension AuthPresenter {
    @MainActor
    func handleSuccess(response: TokensResponseMo?) {
        guard let response = response else {
            return
        }

        if let token = response.accessToken {
            KeychainJWTProvider.shared.save(.accessToken, token)
        }

        if let token = response.refreshToken {
            KeychainJWTProvider.shared.save(.refreshToken, token)
        }

        router.goToMainTabBar()
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
}

// MARK: - Constants

fileprivate extension AuthPresenter {

    // delete if not needed
    // enum Constants {}
}
