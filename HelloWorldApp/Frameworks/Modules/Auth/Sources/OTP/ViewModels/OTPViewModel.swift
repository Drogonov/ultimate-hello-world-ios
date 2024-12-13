//
//  OTPViewModel.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import SwiftUI

struct OTPViewModel {
    var navigationTitle: String
    var otpTextFieldData: [Int: String]
    var otpFocusedTextFieldIndex: Int?
    var verifyButtonText: String
    var isVerifyButtonLoading: Bool
    var isVerifyButtonEnabled: Bool
    var resendButtonText: String
}
