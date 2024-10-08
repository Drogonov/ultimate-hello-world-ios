//
//  ChangeLanguageModels.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 10/06/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

// MARK: - ChangeLanguageModel

struct ChangeLanguageModel: Equatable {

    // MARK: Public Properties

    let title: String
    let languages: [LanguageModel]
}

// MARK: - LanguageModel

struct LanguageModel: Equatable {

    // MARK: Public Properties
    
    let title: String
    let isSelected: Bool
}
