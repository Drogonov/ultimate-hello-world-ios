//
//  AuthRouter.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import CommonApplication
import DI

// MARK: - AuthRouter

final class AuthRouter: BaseRouter {}

// MARK: - AuthRouterInput

extension AuthRouter: AuthRouterInput {
    func goToMainTabBar() {
        openMainTabBarAsFirsNavigationController()
    }

    func goToOTPModule(dataStorage: OTPDataStorage) {
        let configurator = MVPModuleConfigurator(AuthFlowModuleFactory.otpModule())
        let viewController = configurator.getViewController()
        configurator.configure { (input: OTPModuleInput?) in
            input?.set(dataStorage: dataStorage)
        }

        show(viewController, animated: true)
    }
}
