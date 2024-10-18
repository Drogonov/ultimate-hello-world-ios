//
//  MoreInfoViewModel.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 16/06/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Common

// MARK: - MoreInfoViewModel

class MoreInfoViewModel: ObservableObject {

    // MARK: Public Properties

    var navigationTitle: String = .empty
    @Published var imageUrl: URL? = nil
    @Published var text: String = .empty
    @Published var buttonTitle: String = .empty
}
