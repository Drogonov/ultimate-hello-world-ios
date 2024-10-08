//
//  ErrorResponseMo.swift
//  CommonNet
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import ObjectMapper

public class ErrorResponseMo: BaseResponse, @unchecked Sendable {

    public private(set) var errorMsg: String?
    public private(set) var errorCodeValue: String
    public private(set) var errorSubCodeValue: String?
    public private(set) var errorFields: [ErrorDetailMo]?

    public var errorCode: APIErrorCode {
        APIErrorCode(mandatory: errorCodeValue)
    }

    public var errorSubCode: APIErrorSubCode? {
        APIErrorSubCode(optional: errorSubCodeValue)
    }

    required public init(map: Map) throws {
        errorMsg = try? map.value(Constants.strings.errorMsg)
        errorCodeValue = try map.value(Constants.strings.errorCode)
        errorSubCodeValue = try? map.value(Constants.strings.errorSubCode)
        errorFields = try? map.value(Constants.strings.errorFields)

        try super.init(map: map)
    }

    public override func mapping(map: Map) {
        super.mapping(map: map)

        errorMsg >>> map[Constants.strings.errorMsg]
        errorCodeValue >>> map[Constants.strings.errorCode]
        errorSubCodeValue >>> map[Constants.strings.errorSubCode]
        errorFields >>> map[Constants.strings.errorFields]
    }

// MARK: - Constants

    private enum Constants {
        enum strings {
            static let errorMsg = "errorMsg"
            static let errorCode = "errorCode"
            static let errorSubCode = "errorSubCode"
            static let errorFields = "errorFields"
        }
    }
}

extension ErrorResponseMo {

    public convenience init(errorMsg: String? = nil, errorCode: String, errorSubCode: String? = nil, errorFields: [ErrorDetailMo]? = nil) throws {
        var JSON: [String: Any] = [
            Constants.strings.errorCode: errorCode
        ]

        if let errorMsg = errorMsg {
            JSON[Constants.strings.errorMsg] = errorMsg
        }

        if let errorSubCode = errorSubCode {
            JSON[Constants.strings.errorSubCode] = errorSubCode
        }

        if let errorFields = errorFields {
            JSON[Constants.strings.errorFields] = errorFields.toJSON()
        }

        try self.init(JSONObject: JSON)
    }
}

extension ErrorResponseMo {

    public func convertToTopLayerError() -> TopLayerError {
        TopLayerError(error: self)
    }
}
