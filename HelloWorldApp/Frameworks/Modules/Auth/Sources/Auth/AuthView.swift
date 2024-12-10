//
//  AuthView.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import SwiftUI
import Combine
import MasterComponents

// MARK: - AuthView

struct AuthView: View {

    // MARK: Properties

    @ObservedObject var model: AuthViewModel
    var buttonTapped: () -> Void

    @FocusState private var focusedField: FocusableField?

    // MARK: Construction

    var body: some View {
        ScrollView {
            VStack {
                Picker(Constants.pickerName, selection: $model.authMode) {
                    Text(model.loginPlaceholder).tag(AuthMode.login)
                    Text(model.registerPlaceholder).tag(AuthMode.register)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                LabeledContent {
                    TextField(
                        model.emailTextField.placeholder,
                        text: $model.emailTextField.text
                    )
                    .textFieldStyle(.roundedBorder)
                    .focused($focusedField, equals: .email)
                    .padding()
                    .onSubmit {
                        focusedField = .password
                    }
                    .disabled(model.isButtonLoading)
                    .textCase(.lowercase)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                } label: {
                    Text(model.emailTextField.subtitle)
                        .padding(.horizontal, MCSpacing.spacing2XL)
                        .foregroundStyle(model.emailTextField.subtitleColor)
                }
                .labeledContentStyle(BottomLabeledTextFieldStyleConfig())

                LabeledContent {
                    SecureField(
                        model.passwordTextField.placeholder,
                        text: $model.passwordTextField.text
                    )
                    .textFieldStyle(.roundedBorder)
                    .focused($focusedField, equals: .password)
                    .padding()
                    .onSubmit {
                        if model.authMode == .register {
                            focusedField = .confirmPassword
                        } else {
                            focusedField = nil
                        }
                    }
                    .textInputAutocapitalization(.never)
                    .disabled(model.isButtonLoading)
                } label: {
                    Text(model.passwordTextField.subtitle)
                        .padding(.horizontal, MCSpacing.spacing2XL)
                        .foregroundStyle(model.passwordTextField.subtitleColor)
                }
                .labeledContentStyle(BottomLabeledTextFieldStyleConfig())

                if model.authMode == .register {
                    LabeledContent {
                        SecureField(
                            model.confirmPasswordTextField.placeholder,
                            text: $model.confirmPasswordTextField.text
                        )
                        .textFieldStyle(.roundedBorder)
                        .focused($focusedField, equals: .confirmPassword)
                        .padding()
                        .onSubmit {
                            focusedField = nil
                        }
                        .disabled(model.isButtonLoading)
                        .textInputAutocapitalization(.never)
                    } label: {
                        Text(model.confirmPasswordTextField.subtitle)
                            .padding(.horizontal, MCSpacing.spacing2XL)
                            .foregroundStyle(model.confirmPasswordTextField.subtitleColor)
                    }
                    .labeledContentStyle(BottomLabeledTextFieldStyleConfig())
                }

                Spacer()

                Button(model.buttonText) {
                    buttonTapped()
                }
                .loading(model.isButtonLoading)
                .disabled(!model.isButtonEnabled)
                .buttonStyle(.main)
                .padding(.horizontal, MCSpacing.spacingL)

                Spacer()
            }
        }
    }
}

// MARK: - Inner Types

fileprivate extension AuthView {
    enum FocusableField: Hashable {
        case email
        case password
        case confirmPassword
    }
}

// MARK: - Constants

fileprivate extension AuthView {
    enum Constants {
        static let pickerName = "Auth Mode"
    }
}

// MARK: - AuthView_Previews

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = AuthViewModel()
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
        viewModel.emailTextField.placeholder = model.emailPlaceholder ?? .empty
        viewModel.emailTextField.subtitle = "Error"
        viewModel.emailTextField.subtitleColor = .red
        viewModel.passwordTextField.placeholder = model.passwordPlaceholder ?? .empty
        viewModel.confirmPasswordTextField.placeholder = model.confirmPasswordPlaceholder ?? .empty
        viewModel.buttonText = model.buttonText ?? .empty
        viewModel.isButtonEnabled = true
        viewModel.isButtonLoading = true

        return AuthView(
            model: viewModel,
            buttonTapped: { }
        )
    }
}
