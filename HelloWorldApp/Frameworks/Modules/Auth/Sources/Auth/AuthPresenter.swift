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
import Common
import CommonApplication

// MARK: - AuthPresenter

class AuthPresenter {

    // MARK: Public Properties

    weak var view: AuthViewInput?

    // MARK: Private Properties

    private weak var moduleOutput: AuthModuleOutput?

    private var router: AuthRouterInput
    private var dataStorage: AuthDataStorage?

    @DelayedImmutable var authNetworkService: AuthNetworkServiceProtocol?

    @ObservedObject var viewModel = AuthViewModel()

    // MARK: Services

    // MARK: Init

    init(
        router: AuthRouterInput
    ) {
        self.router = router
        viewModel.delegate = self
    }
}

// MARK: - AuthPresenterInput

extension AuthPresenter: AuthPresenterInput {
    func viewIsReady() {
        viewModel.authMode = .login
        updateViewModel()
        view?.setView(with: viewModel)
    }

    func viewWillAppear() {}

    func viewWillDissapear() {}

    func viewButtonTapped() {
        switch viewModel.authMode {
        case .login:
            handleSingInFlow()

        case .register:
            handleSingUpFlow()
        }
    }

    func getEmptyModel() -> AuthViewModel {
        viewModel
    }
}

// MARK: - AuthModuleInput

extension AuthPresenter: AuthModuleInput {
    func set(dataStorage: AuthDataStorage) {
        self.dataStorage = dataStorage

    }
    
    func setModuleOutput(_ moduleOutput: MVPModuleOutputProtocol) {
        self.moduleOutput = moduleOutput as? AuthModuleOutput
    }
}

extension AuthPresenter: AuthViewModelDelegate {
    func authModeDidChange() {
        updateViewModel()
    }
    
    func textFieldDidChange() {
        viewModel.isButtonEnabled = isRequestEnabled()
    }
}


// MARK: - AuthModuleOutput

extension AuthPresenter: AuthModuleOutput {}

// MARK: - Task

fileprivate extension AuthPresenter {
    func handleSingInFlow() {
        let email = viewModel.emailTextField.text
        let password = viewModel.passwordTextField.text

        guard email.isNotEmpty,
              password.isNotEmpty else {
            return
        }

        let request = AuthRequestMo(email: email, password: password)
        viewModel.isButtonLoading = true

        Task {
            do {
                let response = try await authNetworkService?.singInData(request: request, forceRequest: false)
                viewModel.isButtonLoading = false
                handleSingInSuccess(response: response)
            } catch {
                viewModel.isButtonLoading = false
                handleSingInFailure(error: error.getTopLayerErrorResponse())
            }
        }
    }

    func handleSingUpFlow() {
        let email = viewModel.emailTextField.text
        let password = viewModel.passwordTextField.text

        if arePasswordsNotEqual() {
            viewModel.confirmPasswordTextField.subtitle = "Пароли не совпадают"
            return
        } else {
            viewModel.confirmPasswordTextField.subtitle = .empty
        }

        guard email.isNotEmpty,
              password.isNotEmpty else {
            return
        }

        let request = AuthRequestMo(email: email, password: password)
        viewModel.isButtonLoading = true

        Task {
            do {
                let response = try await authNetworkService?.singUpData(request: request, forceRequest: false)
                viewModel.isButtonLoading = false
                handleSingUpSuccess(response: response)
            } catch {
                viewModel.isButtonLoading = false
                handleSingUpFailure(error: error.getTopLayerErrorResponse())
            }
        }
    }
}

// MARK: - @MainActor Handle

fileprivate extension AuthPresenter {
    @MainActor
    func handleSingInSuccess(response: TokensResponseMo?) {
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
    func handleSingUpSuccess(response: StatusResponseMo??) {
        guard let response = response else {
            return
        }

        if let status = StatusType(rawValue: response?.status ?? .empty),
            status  == .success {
            router.goToOTPModule(dataStorage: OTPDataStorage(
                email: viewModel.emailTextField.text,
                password: viewModel.passwordTextField.text
            ))
        } else {
            handleAlert(
                title: "Cant show OTP",
                message: "Some problems happend"
            )
        }
    }

    @MainActor
    func handleSingInFailure(error: ErrorResponseMo?) {
        guard let error = error else {
            return
        }

        switch error.errorSubCode {
        case .userDoesntExist, .incorrectPassword, .incorrectEmail:
            updateFields(error: error)

        case .userNotVerified:
            handleAlert(
                title: "Нужно пройти верификацию",
                message: "Мы уже выслали на вашу почту номер для подтреждения аккаунта, пожалуйста введите его далее",
                firstAction: {
                    self.router.goToOTPModule(dataStorage: OTPDataStorage(
                        email: self.viewModel.emailTextField.text,
                        password: self.viewModel.passwordTextField.text
                    ))
                }
            )

        default:
            handleAlert(title: "Error", message: error.errorMsg)
        }
    }

    @MainActor
    func handleSingUpFailure(error: ErrorResponseMo?) {
        guard let error = error else {
            return
        }

        switch error.errorSubCode {
        case .incorrectEmail, .incorrectPassword:
            updateFields(error: error)

        case .cantDeliverVerificationEmail:
            handleAlert(title: "Проблема с верификацией", message: error.errorMsg)

        default:
            handleAlert(title: "Error", message: error.errorMsg)
        }
    }
}


// MARK: - Private Methods

fileprivate extension AuthPresenter {
    func updateFields(error: ErrorResponseMo) {
        if let errorMsg = authNetworkService?.doesErrorFieldsContainsText(errorFields: error.errorFields, field: .email) {
            viewModel.emailTextField.subtitle = errorMsg
            viewModel.emailTextField.subtitleColor = .red
            return
        }

        if let errorMsg = authNetworkService?.doesErrorFieldsContainsText(errorFields: error.errorFields, field: .password) {
            viewModel.passwordTextField.subtitle = errorMsg
            viewModel.passwordTextField.subtitleColor = .red
            return
        }
    }

    func handleAlert(
        title: String?,
        message: String?,
        firstAction: VoidBlock? = nil
    ) {
        let body = NativeAlertViewModel.Body(
            title: title,
            message: message
        )

        let buttons = NativeAlertViewModel.Buttons(
            firstTitle: ResourcesStrings.ok(),
            firstAction: firstAction
        )

        let viewModel = NativeAlertViewModel(
            body: body,
            buttons: buttons
        )

        showNativeAlert(viewModel: viewModel)
    }

    func isRequestEnabled() -> Bool {
        switch viewModel.authMode {
        case .login:
            viewModel.emailTextField.text.isNotEmpty
            && viewModel.passwordTextField.text.isNotEmpty

        case .register:
            viewModel.emailTextField.text.isNotEmpty
            && viewModel.passwordTextField.text.isNotEmpty
            && viewModel.confirmPasswordTextField.text.isNotEmpty
            && !arePasswordsNotEqual()
        }
    }

    func arePasswordsNotEqual() -> Bool {
        viewModel.passwordTextField.text != viewModel.confirmPasswordTextField.text
    }

    func updateViewModel() {
        let model = AuthModel(
            title: "Auth",
            loginPlaceholder: "Login",
            registerPlaceholder: "Register",
            emailPlaceholder: "Email",
            passwordPlaceholder: "Password",
            confirmPasswordPlaceholder: "Confirm Password",
            buttonText: "Submit"
        )

        viewModel.navigationTitle = model.title ?? .empty

        viewModel.loginPlaceholder = model.loginPlaceholder ?? .empty
        viewModel.registerPlaceholder = model.registerPlaceholder ?? .empty

        viewModel.emailTextField.text = .empty
        viewModel.emailTextField.placeholder = model.emailPlaceholder ?? .empty
        viewModel.emailTextField.subtitle = .empty

        viewModel.passwordTextField.text = .empty
        viewModel.passwordTextField.placeholder = model.passwordPlaceholder ?? .empty
        viewModel.passwordTextField.subtitle = .empty

        viewModel.confirmPasswordTextField.text = .empty
        viewModel.confirmPasswordTextField.placeholder = model.confirmPasswordPlaceholder ?? .empty
        viewModel.confirmPasswordTextField.subtitle = .empty

        viewModel.buttonText = model.buttonText ?? .empty
    }
}

// MARK: - Constants

fileprivate extension AuthPresenter {

    // delete if not needed
    // enum Constants {}
}
