//
//  OTPProtocolsProtocols.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import DI
import MasterComponents
import CommonApplication

// MARK: - Module Protocols

// sourcery: AutoMockable
public protocol OTPModuleOutput: MVPModuleOutputProtocol {}

// MARK: - View Protocols

// sourcery: AutoMockable
protocol OTPViewInput: AnyObject {
    func setView(with viewModel: OTPViewModel)
}

// MARK: - Presenter Protocols

// sourcery: AutoMockable
protocol OTPPresenterInput: NativeAlertProtocol {
    func viewIsReady()
    func viewWillAppear()
    func viewWillDissapear()

    func verifyButtonTapped(otp: String)
    func resendButtonTapped()

    func getEmptyModel() -> OTPViewModel
}

// MARK: - Router Protocols

// sourcery: AutoMockable
protocol OTPRouterInput: BaseRouterInput {
    func goToMainTabBar()
}
