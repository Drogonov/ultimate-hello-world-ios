//
//  MagicViewModel.swift
//  Magic
//
//  Created by Anton Vlezko on 16/06/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Common

// MARK: - MagicViewModel

class MagicViewModel: ObservableObject {

    // MARK: Public Properties

    var navigationTitle: String = .empty
    @Published var mainText: String = .empty
    @Published var jokeText: String = .empty
    @Published var infoText: String = .empty
}
