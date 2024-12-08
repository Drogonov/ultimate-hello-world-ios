//
//  AuthViewModel.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation

// MARK: - AuthMode

enum AuthMode {
    case login
    case register
}

// MARK: - AuthViewModel

class AuthViewModel: ObservableObject {

    // MARK: Public Properties

    var navigationTitle: String = .empty

    @Published var authMode: AuthMode = .login
    @Published var loginPlaceholder: String = .empty
    @Published var registerPlaceholder: String = .empty

    @Published var emailPlaceholder: String = .empty
    @Published var passwordPlaceholder: String = .empty
    @Published var confirmPasswordPlaceholder: String = .empty

    @Published var email: String = .empty
    @Published var password: String = .empty
    @Published var confirmPassword: String = .empty

    @Published var buttonText: String = .empty
}
