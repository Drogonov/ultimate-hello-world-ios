//
//  OTPViewModel.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation

// MARK: - OTPViewModel

class OTPViewModel: ObservableObject {

    // MARK: Public Properties

    var navigationTitle: String = "OTP Verification"
    @Published var text: String = .empty
}
