//
//  AuthRouter.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import CommonApplication

// MARK: - AuthRouter

final class AuthRouter: BaseRouter {}

// MARK: - AuthRouterInput

extension AuthRouter: AuthRouterInput {
    func goToMainTabBar() {
        openMainTabBarAsFirsNavigationController()
    }
}
