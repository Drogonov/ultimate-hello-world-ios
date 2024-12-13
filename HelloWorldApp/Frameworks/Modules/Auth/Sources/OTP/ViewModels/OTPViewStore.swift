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

class OTPViewStore: OTPViewStoreProtocol {

    // MARK: Public Properties

    var delegate: OTPViewStoreDelegate?

    var navigationTitle: String = "OTP Verification"
    @Published var otpTextFields: [Int: String] = [:]
    @Published var otpFocusedTextFieldIndex: Int?
    @Published var verifyButtonText: String = .empty
    @Published var isVerifyButtonLoading: Bool = false
    @Published var isVerifyButtonEnabled: Bool = false
    @Published var resendButtonText: String = .empty

    // MARK: - Methods

    func didChangeOTPTextField(with index: Int, text: String) {
        delegate?.didChangeOTPTextField(with: index, text: text)
    }

    func didTapOTPTextField(with index: Int) {
        delegate?.didTapOTPTextField(with: index)
    }

    func didTapVerifyButton() {
        delegate?.didTapVerifyButton()
    }

    func didTapResendButton() {
        delegate?.didTapVerifyButton()
    }

    // MARK: OTPViewStoreProtocol

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
