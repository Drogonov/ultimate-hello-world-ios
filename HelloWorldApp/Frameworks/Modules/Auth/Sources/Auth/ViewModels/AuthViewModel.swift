//
//  AuthViewModel.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import SwiftUI
import MasterComponents


// MARK: - AuthMode

enum AuthMode {
    case login
    case register
}

// MARK: - AuthViewModel

class AuthViewModel: ObservableObject {

    // MARK: Public Properties

    var delegate: AuthViewModelDelegate?

    var navigationTitle: String = .empty

    @Published var authMode: AuthMode = .login {
        didSet {
            delegate?.authModeDidChange()
        }
    }
    @Published var loginPlaceholder: String = .empty
    @Published var registerPlaceholder: String = .empty

    @Published var emailTextField: TextFieldViewModel = .init() {
        didSet {
            delegate?.textFieldDidChange()
        }
    }
    @Published var passwordTextField: TextFieldViewModel = .init() {
        didSet {
            delegate?.textFieldDidChange()
        }
    }
    @Published var confirmPasswordTextField: TextFieldViewModel = .init() {
        didSet {
            delegate?.textFieldDidChange()
        }
    }

    @Published var buttonText: String = .empty
    @Published var isButtonEnabled: Bool = false
    @Published var isButtonLoading: Bool = false
}

// MARK: - TextFieldViewModel

struct TextFieldViewModel: Equatable {
    var text: String = .empty
    var placeholder: String = .empty
    var subtitle: String = .empty
    var subtitleColor: Color = .textSecondaryColor
}
