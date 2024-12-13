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

protocol OTPViewStoreProtocol: ObservableObject {
    var delegate: OTPViewStoreDelegate? { get set }
    func update(with viewModel: OTPViewModel)
}

protocol OTPViewStoreDelegate {
    func didChangeOTPTextField(with index: Int, text: String)
    func didTapOTPTextField(with index: Int)
    func didTapVerifyButton()
    func didTapResendButton()
}

// MARK: - Presenter Protocols

// sourcery: AutoMockable
protocol OTPPresenterInput: NativeAlertProtocol {
    func viewIsReady()
    func viewDidChangeOTPTextField(with index: Int, text: String)
    func viewDidTapVerifyButton()
    func viewDidTapResendButton()
    func viewDidTapOTPTextField(with index: Int)
}

// MARK: - Router Protocols

// sourcery: AutoMockable
protocol OTPRouterInput: BaseRouterInput {
    func goToMainTabBar()
}
