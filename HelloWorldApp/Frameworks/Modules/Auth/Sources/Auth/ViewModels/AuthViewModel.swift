//
//  AuthViewModel.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import MasterComponents
import SwiftUI

// MARK: - AuthViewModel

struct AuthViewModel {

    // MARK: Public Properties

    var navigationTitle: String

    var authMode: AuthMode
    var loginPlaceholder: String
    var registerPlaceholder: String

    var textFields: [TextFieldViewModel]

    var buttonText: String
    var isButtonEnabled: Bool
    var isButtonLoading: Bool
}

// MARK: - AuthMode

enum AuthMode {
    case login
    case register
}

// MARK: - TextFieldViewModel

struct TextFieldViewModel: Equatable {
    var type: AuthTextFieldType
    var text: String
    var placeholder: String
    var subtitle: String
    var subtitleColor: Color = .textSecondaryColor
    var isSecure: Bool
    var nextFieldType: AuthTextFieldType?
}

// MARK: - AuthTextFieldType

enum AuthTextFieldType: Hashable {
    case email
    case password
    case confirmPassword
}
