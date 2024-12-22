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
    private var viewModel: AuthViewModel?

    // MARK: Services

    @DelayedImmutable var authNetworkService: AuthNetworkServiceProtocol?

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
        viewModel = getDefaultViewModel(.login)

        if let viewModel {
            view?.setView(with: viewModel)
        }
    }

    func viewDidChangeTextField(type: AuthTextFieldType, text: String) {
        updateTextFieldText(type, text: text)
        updateIsEnabled()

        if let viewModel {
            view?.setView(with: viewModel)
        }
    }

    func viewDidChangeAuthMode(mode: AuthMode) {
        viewModel = getDefaultViewModel(mode)

        if let viewModel {
            view?.setView(with: viewModel)
        }
    }

    func viewDidTapSubmitButton() {
        guard let viewModel else {
            return
        }

        switch viewModel.authMode {
        case .login:
            handleSingInFlow()

        case .register:
            handleSingUpFlow()
        }
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

// MARK: - AuthModuleOutput

extension AuthPresenter: AuthModuleOutput {}

// MARK: - Task

fileprivate extension AuthPresenter {
    func handleSingInFlow() {
        guard let email = getTextField(.email)?.text,
              let password = getTextField(.password)?.text,
              email.isNotEmpty,
              password.isNotEmpty else {
            return
        }

        let request = AuthRequestMo(email: email, password: password)
        viewModel?.isButtonLoading = true

        Task {
            do {
                let response = try await authNetworkService?.singInData(request: request, forceRequest: false)
                viewModel?.isButtonLoading = false
                await handleSingInSuccess(response: response)
            } catch {
                viewModel?.isButtonLoading = false
                await handleSingInFailure(error: error.getTopLayerErrorResponse())
            }
        }
    }

    func handleSingUpFlow() {
        guard let email = getTextField(.email)?.text,
              let password = getTextField(.password)?.text,
              email.isNotEmpty,
              password.isNotEmpty else {
            return
        }

        if arePasswordsNotEqual() {
            updateTextFieldSubtitle(.confirmPassword, subtitle: "Пароли не совпадают", color: .textSecondaryColor)
            return
        } else {
            updateTextFieldSubtitle(.confirmPassword, subtitle: .empty, color: .textSecondaryColor)
        }

        guard email.isNotEmpty,
              password.isNotEmpty else {
            return
        }

        let request = AuthRequestMo(email: email, password: password)
        viewModel?.isButtonLoading = true

        Task {
            do {
                let response = try await authNetworkService?.singUpData(request: request, forceRequest: false)
                viewModel?.isButtonLoading = false
                await handleSingUpSuccess(response: response)
            } catch {
                viewModel?.isButtonLoading = false
                await handleSingUpFailure(error: error.getTopLayerErrorResponse())
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
            handleGoToOTPModule()
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
                firstAction: { [weak self] in
                    self?.handleGoToOTPModule()
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
    func handleGoToOTPModule() {
        guard let email = getTextField(.email)?.text,
              let password = getTextField(.password)?.text,
              email.isNotEmpty,
              password.isNotEmpty else {
            return
        }

        router.goToOTPModule(dataStorage: OTPDataStorage(
            email: email,
            password: password
        ))
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

    func updateFields(error: ErrorResponseMo) {
        if let errorMsg = authNetworkService?.doesErrorFieldsContainsText(errorFields: error.errorFields, field: .email) {
            updateTextFieldSubtitle(.email, subtitle: errorMsg, color: .red)
            return
        }

        if let errorMsg = authNetworkService?.doesErrorFieldsContainsText(errorFields: error.errorFields, field: .password) {
            updateTextFieldSubtitle(.password, subtitle: errorMsg, color: .red)
            return
        }
    }

    func updateTextFieldText(_ type: AuthTextFieldType, text: String) {
        if let index = viewModel?.textFields.firstIndex(where: { $0.type == type }) {
            viewModel?.textFields[index].text = text
        }
    }

    func updateTextFieldSubtitle(_ type: AuthTextFieldType, subtitle: String, color: Color) {
        if let index = viewModel?.textFields.firstIndex(where: { $0.type == type }) {
            viewModel?.textFields[index].subtitle = subtitle
            viewModel?.textFields[index].subtitleColor = color
        }
    }

    func updateIsEnabled() {
        guard let viewModel = viewModel else {
            return
        }
        let isEnabled: Bool

        let emailText = viewModel.textFields.first(where: { $0.type == .email })?.text
        let passwordText = viewModel.textFields.first(where: { $0.type == .password })?.text
        let confirmPasswordText = viewModel.textFields.first(where: { $0.type == .confirmPassword })?.text

        switch viewModel.authMode {
        case .login:
            isEnabled = emailText.isNotEmpty
            && passwordText.isNotEmpty

        case .register:
            isEnabled = emailText.isNotEmpty
            && passwordText.isNotEmpty
            && confirmPasswordText.isNotEmpty
            && emailText == passwordText
        }

        self.viewModel?.isButtonEnabled = isEnabled
    }

    func arePasswordsNotEqual() -> Bool {
        getTextField(.password)?.text != getTextField(.confirmPassword)?.text
    }

    func getTextField(_ type: AuthTextFieldType) -> TextFieldViewModel? {
        viewModel?.textFields.first(where: { $0.type == type })
    }

    func getDefaultViewModel(_ authMode: AuthMode) -> AuthViewModel {
        var textFields: [TextFieldViewModel] = []

        let emailTextField = TextFieldViewModel(
            type: .email,
            text: .empty,
            placeholder: "Email",
            subtitle: .empty,
            isSecure: false,
            nextFieldType: .password
        )
        textFields.append(emailTextField)

        let passwordTextField = TextFieldViewModel(
            type: .password,
            text: .empty,
            placeholder: "Password",
            subtitle: .empty,
            isSecure: true,
            nextFieldType: authMode == .login ? nil : .confirmPassword
        )
        textFields.append(passwordTextField)

        if authMode == .register {
            let confirmPassword = TextFieldViewModel(
                type: .confirmPassword,
                text: .empty,
                placeholder: "Confirm Password",
                subtitle: .empty,
                isSecure: true,
                nextFieldType: nil
            )
            textFields.append(confirmPassword)
        }

        return AuthViewModel(
            navigationTitle: "Auth",
            authMode: authMode,
            loginPlaceholder: "Login",
            registerPlaceholder: "Register",
            textFields: textFields,
            buttonText: "Submit",
            isButtonEnabled: false,
            isButtonLoading: false
        )
    }
}
