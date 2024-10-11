//
//  OnboardingViewModel.swift
//  Magic
//
//  Created by Anton Vlezko on 11/10/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation

// MARK: - OnboardingViewModel

class OnboardingViewModel: ObservableObject {

    // MARK: Public Properties

    @Published var text: String = .empty
    @Published var buttonText: String = .empty
}
