//
//  AuthProtocolsProtocols.swift
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
public protocol AuthModuleOutput: MVPModuleOutputProtocol {}

// MARK: - View Protocols

// sourcery: AutoMockable
protocol AuthViewInput: AnyObject {
    func setView(with viewModel: AuthViewModel)
}

// MARK: - Presenter Protocols

// sourcery: AutoMockable
protocol AuthPresenterInput: NativeAlertProtocol {
    func viewIsReady()
    func viewWillAppear()
    func viewWillDissapear()

    func viewButtonTapped()

    func getEmptyModel() -> AuthViewModel
}

// sourcery: AutoMockable
protocol AuthViewModelDelegate {
    func textFieldDidChange()
    func authModeDidChange()
}

// MARK: - Router Protocols

// sourcery: AutoMockable
protocol AuthRouterInput: BaseRouterInput {
    func goToMainTabBar()
    func goToOTPModule(dataStorage: OTPDataStorage)
}
