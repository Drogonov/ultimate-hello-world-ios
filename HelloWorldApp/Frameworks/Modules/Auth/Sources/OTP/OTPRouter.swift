//
//  OTPRouter.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import CommonApplication

// MARK: - OTPRouter

final class OTPRouter: BaseRouter {}

// MARK: - OTPRouterInput

extension OTPRouter: OTPRouterInput {
    func goToMainTabBar() {
        openMainTabBarAsFirsNavigationController()
    }
}
