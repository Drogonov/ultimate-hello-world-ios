//
//  OnboardingRouter.swift
//  Magic
//
//  Created by Anton Vlezko on 11/10/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import CommonApplication

// MARK: - OnboardingRouter

final class OnboardingRouter: BaseRouter {}

// MARK: - OnboardingRouterInput

extension OnboardingRouter: OnboardingRouterInput {
    func goToMainTabBar() {
        openMainTabBarAsFirsNavigationController()
    }
}
