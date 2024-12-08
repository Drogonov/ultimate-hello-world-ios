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
    @Published var text: String = .empty
}
