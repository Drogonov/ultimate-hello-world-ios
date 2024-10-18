//
//  APIErrorCode.swift
//  CommonNet
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

public enum APIErrorCode: String, BusinessLogicCode, UnknownCaseRepresantable {
    case businessError = "BUSINESS_ERROR"
    case unknownError = "UNKNOWN_ERROR"
    case validationError = "VALIDATION_ERROR"
    case warning = "WARNING"
    case unsupported = "UNSUPPORTED"
    case redirectRequired = "REDIRECT_REQUIRED"
    case invalid

    // MARK: Properties

    public static var unknownCase: APIErrorCode {
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

public enum APIErrorSubCode: String, BusinessLogicCode, UnknownCaseRepresantable {
    case emptyResult = "EMPTY_RESULT"
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
