//
//  OTPViewStore.swift
//  Auth
//
//  Created by Anton Vlezko on 13/12/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import SwiftUI
import Foundation

// MARK: - OTPViewStore

class OTPViewStore {

    // MARK: Public Properties

    var delegate: OTPViewActionProtocol?

    var navigationTitle: String = .empty
    @Published var otpTextFields: [Int: String] = [:]
    @Published var otpFocusedTextFieldIndex: Int?
    @Published var verifyButtonText: String = .empty
    @Published var isVerifyButtonLoading: Bool = false
    @Published var isVerifyButtonEnabled: Bool = false
    @Published var resendButtonText: String = .empty
}

// MARK: - OTPViewStoreInput

extension OTPViewStore: OTPViewStoreInput {
    func viewDidChangeOTPTextField(with index: Int, text: String) {
        delegate?.viewDidChangeOTPTextField(with: index, text: text)
    }
    
    func viewDidTapOTPTextField(with index: Int) {
        delegate?.viewDidTapOTPTextField(with: index)
    }
    
    func viewDidTapVerifyButton() {
        delegate?.viewDidTapVerifyButton()
    }
    
    func viewDidTapResendButton() {
        delegate?.viewDidTapVerifyButton()
    }
    
    func update(with viewModel: OTPViewModel) {
        navigationTitle = viewModel.navigationTitle
        otpTextFields = viewModel.otpTextFieldData
        otpFocusedTextFieldIndex = viewModel.otpFocusedTextFieldIndex
        verifyButtonText = viewModel.verifyButtonText
        isVerifyButtonLoading = viewModel.isVerifyButtonLoading
        isVerifyButtonEnabled = viewModel.isVerifyButtonEnabled
        resendButtonText = viewModel.resendButtonText
    }
}
