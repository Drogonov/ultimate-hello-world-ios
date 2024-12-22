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

// sourcery: AutoMockable
protocol AuthViewStoreInput: ObservableObject, AuthViewActionProtocol {
    var delegate: AuthViewActionProtocol? { get set }
    func update(with viewModel: AuthViewModel)
}

// sourcery: AutoMockable
protocol AuthViewActionProtocol: AnyObject {
    func viewDidChangeTextField(type: AuthTextFieldType, text: String)
    func viewDidChangeAuthMode(mode: AuthMode)
    func viewDidTapSubmitButton()
}

// MARK: - Presenter Protocols

// sourcery: AutoMockable
protocol AuthPresenterInput: NativeAlertProtocol, AuthViewActionProtocol {
    func viewIsReady()
}

// MARK: - Router Protocols

// sourcery: AutoMockable
protocol AuthRouterInput: BaseRouterInput {
    func goToMainTabBar()
    func goToOTPModule(dataStorage: OTPDataStorage)
}
