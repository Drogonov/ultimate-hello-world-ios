//
//  VerifyOTPRequestMo.swift
//  Services
//
//  Created by Anton Vlezko on 26/11/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import ObjectMapper
import Net

open class VerifyOTPRequestMo: BaseRequest {

    /// Some Text
    public private(set) var code: String?

    public init(
        code: String?
    ) {
        self.code = code

        super.init()
    }

    public required init?(map: Map) {
        fatalError("Not implemented. Use init(...) instead")
    }

    open override func mapping(map: Map) {
        code <- map[Constants.code]
    }
}

// MARK: - Constants

fileprivate extension VerifyOTPRequestMo {
    enum Constants {
        static let code = "code"
    }
}
