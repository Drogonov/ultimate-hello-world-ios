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

    @ObservedObject var store: AuthViewStore

    // MARK: - Private Properties

    @FocusState private var focusedField: AuthTextFieldType?

    // MARK: Construction

    var body: some View {
        ScrollView {
            VStack {
                Picker(Constants.pickerName, selection: $store.authMode) {
                    Text(store.loginPlaceholder).tag(AuthMode.login)
                    Text(store.registerPlaceholder).tag(AuthMode.register)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .onChange(of: store.authMode) { oldValue, newValue in
                    store.viewDidChangeAuthMode(mode: newValue)
                }

                ForEach(0..<store.textFields.count, id: \.self) { index in
                    textField(for: index)
                }

                Spacer()
                Spacer()

                Button(store.buttonText) {
                    store.viewDidTapSubmitButton()
                }
                .loading(store.isButtonLoading)
                .disabled(!store.isButtonEnabled)
                .buttonStyle(.main)
                .padding(.horizontal, MCSpacing.spacingL)

                Spacer()
            }
        }
    }
}

fileprivate extension AuthView {
    private func textField(for index: Int) -> some View {
        LabeledContent {
            if store.textFields[index].isSecure {
                TextField(
                    store.textFields[index].placeholder,
                    text: $store.textFields[index].text
                )
                .textFieldStyle(.roundedBorder)
                .focused($focusedField, equals: store.textFields[index].type)
                .padding()
                .onSubmit {
                    focusedField = store.textFields[index].nextFieldType
                }
                .disabled(store.isButtonLoading)
                .textCase(.lowercase)
                .textInputAutocapitalization(.never)
                .keyboardType(store.textFields[index].type == .email ? .emailAddress : .default)
            } else {
                SecureField(
                    store.textFields[index].placeholder,
                    text: $store.textFields[index].text
                )
                .textFieldStyle(.roundedBorder)
                .focused($focusedField, equals: store.textFields[index].type)
                .padding()
                .onSubmit {
                    focusedField = store.textFields[index].nextFieldType
                }
                .disabled(store.isButtonLoading)
                .textCase(.lowercase)
                .textInputAutocapitalization(.never)
            }
        } label: {
            Text(store.textFields[index].subtitle)
                .padding(.horizontal, MCSpacing.spacing2XL)
                .foregroundStyle(store.textFields[index].subtitleColor)
        }
        .labeledContentStyle(BottomLabeledTextFieldStyleConfig())
        .onChange(of: store.textFields[index].text) { oldValue, newValue in
            store.viewDidChangeTextField(type: store.textFields[index].type, text: newValue)
        }
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
        let store = AuthViewStore()

        store.navigationTitle = "Auth"
        store.authMode = .login
        store.loginPlaceholder = "Login"
        store.registerPlaceholder = "Register"

        store.textFields = [
            TextFieldViewModel(type: .email, text: .empty, placeholder: "Email", subtitle: .empty, isSecure: false),
            TextFieldViewModel(type: .password, text: .empty, placeholder: "Password", subtitle: .empty, isSecure: true),
            TextFieldViewModel(type: .confirmPassword, text: .empty, placeholder: "Confirm Password", subtitle: "Passwords Must Be Equal", isSecure: true)
        ]

        store.buttonText = "Submit"
        store.isButtonEnabled = true
        store.isButtonLoading = false

        return AuthView(store: store)
    }
}
