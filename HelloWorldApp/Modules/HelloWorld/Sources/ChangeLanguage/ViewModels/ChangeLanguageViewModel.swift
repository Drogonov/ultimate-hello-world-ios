//
//  ChangeLanguageViewModel.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 10/06/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Common

// MARK: - ChangeLanguageViewModel

class ChangeLanguageViewModel: ObservableObject {

    // MARK: Public Properties

    var navigationTitle: String = .empty
    @Published var languages: [LanguageViewModel] = []
}

// MARK: - LanguageViewModel

struct LanguageViewModel: Identifiable {
    let id: UUID = UUID()
    var title: String
    var isSelected: Bool = false
}
