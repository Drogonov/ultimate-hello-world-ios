//
//  SingUpRequestMo.swift
//  Services
//
//  Created by Anton Vlezko on 26/11/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import ObjectMapper
import Net

open class SingUpRequestMo: BaseRequest {

    /// Email
    public private(set) var email: String?

    /// Password
    public private(set) var password: String?

    public init(
        email: String?,
        password: String?
    ) {
        self.email = email
        self.password = password

        super.init()
    }

    public required init?(map: Map) {
        fatalError("Not implemented. Use init(...) instead")
    }

    open override func mapping(map: Map) {
        email <- map[Constants.email]
        password <- map[Constants.password]
    }
}

// MARK: - Constants

fileprivate extension SingUpRequestMo {
    enum Constants {
        static let email = "email"
        static let password = "password"
    }
}
