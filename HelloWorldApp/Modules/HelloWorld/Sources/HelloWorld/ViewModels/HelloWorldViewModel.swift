//
//  HelloWorldViewModel.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 12/03/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Common

// MARK: - HelloWorldViewModel

class HelloWorldViewModel: ObservableObject {

    // MARK: Public Properties

    var navigationTitle: String = .empty
    var buttonTitle: String = .empty
    @Published var text: String = .empty
}
