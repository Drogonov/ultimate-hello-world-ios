//
//  OTPViewModel.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import SwiftUI

protocol OTPViewModelDelegate {
    func otpTextFieldsDidChange()
}

// MARK: - OTPViewModel

class OTPViewModel: ObservableObject {

    // MARK: Public Properties

    var delegate: OTPViewModelDelegate?

    var navigationTitle: String = "OTP Verification"
    @Published var otpTextFields: [Int: String] = [:] {
        didSet { delegate?.otpTextFieldsDidChange() }
    }
    @Published var verifyButtonText: String = .empty
    @Published var isVerifyButtonLoading: Bool = false
    @Published var isVerifyButtonEnabled: Bool = false
    @Published var resendButtonText: String = .empty
}
