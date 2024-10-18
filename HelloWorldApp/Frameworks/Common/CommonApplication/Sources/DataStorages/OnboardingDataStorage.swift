//
//  OnboardingDataStorage.swift
//  CommonApplication
//
//  Created by Anton Vlezko on 11/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation

// MARK: - OnboardingDataStorage

public struct OnboardingDataStorage {

    // MARK: Public Properties

    public let onboardingText: String
    public let onboardingButtonText: String

    // MARK: Init
    
    public init(
        onboardingText: String,
        onboardingButtonText: String
    ) {
        self.onboardingText = onboardingText
        self.onboardingButtonText = onboardingButtonText
    }
}
