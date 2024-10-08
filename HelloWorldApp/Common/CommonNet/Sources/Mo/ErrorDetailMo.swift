//
//  ErrorDetailMo.swift
//  CommonNet
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import ObjectMapper

public typealias ErrorDetailsFields = [ValidFieldNameKey: String]

public class ErrorDetailMo: BaseResponse {

    /// Code of field with error
    public private(set) var fieldCode: String

    /// Error text
    public private(set) var errorMsg: String

    required public init(map: Map) throws {
        fieldCode = try map.value(Constants.strings.fieldCode)
        errorMsg = try map.value(Constants.strings.errorMsg)

        try super.init(map: map)
    }

    public override func mapping(map: Map) {
        super.mapping(map: map)

        fieldCode <- map[Constants.strings.fieldCode]
        errorMsg <- map[Constants.strings.errorMsg]
    }

// MARK: - Constants

    private enum Constants {
        enum strings {
            static let fieldCode = "fieldCode"
            static let errorMsg = "errorMsg"
            static let confirmationCode = "confirmationCode"
        }
    }
}

extension Array where Element == ErrorDetailMo {

    public func getErrorMessageForCode(_ code: ErrorDetailFieldCodes) -> String? {
        return first(where: { $0.fieldCode == code.rawValue })?.errorMsg
    }

    public func validFields() -> ErrorDetailsFields {
        reduce(into: ErrorDetailsFields()) {
            if let key = ValidFieldNameKey(rawValue: $1.fieldCode) {
                $0[key] = $1.errorMsg
            }
        }
    }
}

extension ErrorDetailMo {
    public class func otpConfirmationError(with errorMsg: String) -> ErrorDetailMo {
        var JSON: [String: Any] = [Constants.strings.fieldCode: Constants.strings.confirmationCode]

        JSON[Constants.strings.errorMsg] = errorMsg

        return try! ErrorDetailMo(JSONObject: JSON)
    }
}

extension ErrorDetailMo {
    public convenience init(fieldCode: String, errorMsg: String) throws {
        let json: [String: Any] = [
            Constants.strings.fieldCode: fieldCode,
            Constants.strings.errorMsg: errorMsg
        ]

        try self.init(JSONObject: json)
    }
}

