//
//  ChangeLanguageViewModel.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 10/06/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Common

// MARK: - ChangeLanguageViewModel

struct ChangeLanguageViewModel {
    var navigationTitle: String
    var languages: [LanguageViewModel]
    var buttonText: String
    var isButtonLoading: Bool
    var isButtonEnabled: Bool
}

// MARK: - LanguageViewModel

struct LanguageViewModel: Identifiable {
    let id: UUID = UUID()
    var title: String
    var isSelected: Bool
}
