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

// sourcery: AutoMockable
protocol OTPViewStoreInput: ObservableObject, OTPViewActionProtocol {
    var delegate: OTPViewActionProtocol? { get set }
    func update(with viewModel: OTPViewModel)
}

// sourcery: AutoMockable
protocol OTPViewActionProtocol: AnyObject {
    func viewDidChangeOTPTextField(with index: Int, text: String)
    func viewDidTapOTPTextField(with index: Int)
    func viewDidTapVerifyButton()
    func viewDidTapResendButton()
}

// MARK: - Presenter Protocols

// sourcery: AutoMockable
protocol OTPPresenterInput: NativeAlertProtocol, OTPViewActionProtocol {
    func viewIsReady()
}

// MARK: - Router Protocols

// sourcery: AutoMockable
protocol OTPRouterInput: BaseRouterInput {
    func goToMainTabBar()
}
