//
//  APIErrorCode.swift
//  CommonNet
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

public enum APIErrorSubCode: String, BusinessLogicCode, UnknownCaseRepresantable {
    case userDoesntExist = "USER_DOESNT_EXIST"
    case userNotVerified = "USER_NOT_VERIFIED"
    case incorrectPassword = "INCORRECT_PASSWORD"
    case incorrectEmail = "INCORRECT_EMAIL"
    case cantDeliverVerificationEmail = "CANT_DELIVER_VERIFICATION_EMAIL"
    case invalid

    // MARK: Properties

    public static var unknownCase: APIErrorSubCode {
        .invalid
    }

    // MARK: Init

    public init?(_ code: String?) {
        guard let code = code else {
            return nil
        }
        self.init(rawValue: code)
    }
}

public enum APIConfirmationType: String {
    case none = "NONE"
}
