//
//  AuthViewStore.swift
//  Auth
//
//  Created by Anton Vlezko on 22/12/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation

// MARK: - AuthViewStore

class AuthViewStore {

    // MARK: Public Properties

    var delegate: AuthViewActionProtocol?

    var navigationTitle: String = .empty

    @Published var authMode: AuthMode = .login
    @Published var loginPlaceholder: String = .empty
    @Published var registerPlaceholder: String = .empty

    @Published var textFields: [TextFieldViewModel] = []

    @Published var buttonText: String = .empty
    @Published var isButtonEnabled: Bool = false
    @Published var isButtonLoading: Bool = false
}

// MARK: - OTPViewStoreInput

extension AuthViewStore: AuthViewStoreInput {
    func viewDidChangeTextField(type: AuthTextFieldType, text: String) {
        delegate?.viewDidChangeTextField(type: type, text: text)
    }

    func viewDidChangeAuthMode(mode: AuthMode) {
        delegate?.viewDidChangeAuthMode(mode: mode)
    }

    func viewDidTapSubmitButton() {
        delegate?.viewDidTapSubmitButton()
    }

    func update(with viewModel: AuthViewModel) {
        navigationTitle = viewModel.navigationTitle
        authMode = viewModel.authMode
        loginPlaceholder = viewModel.loginPlaceholder
        registerPlaceholder = viewModel.registerPlaceholder
        textFields = viewModel.textFields
        buttonText = viewModel.buttonText
        isButtonEnabled = viewModel.isButtonEnabled
        isButtonLoading = viewModel.isButtonLoading
    }
}
