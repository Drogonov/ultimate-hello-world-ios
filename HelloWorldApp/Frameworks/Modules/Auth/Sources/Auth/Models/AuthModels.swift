//
//  AuthModelsModels.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation

// MARK: - AuthModel

struct AuthModel: Equatable {

    // MARK: Public Properties

    let title: String?

    let loginPlaceholder: String?
    let registerPlaceholder: String?

    let emailPlaceholder: String?
    let passwordPlaceholder: String?
    let confirmPasswordPlaceholder: String?

    let buttonText: String?
}
