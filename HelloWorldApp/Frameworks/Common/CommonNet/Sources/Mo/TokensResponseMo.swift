//
//  TokensResponseMo.swift
//  CommonNet
//
//  Created by Anton Vlezko on 26/11/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import ObjectMapper

public class TokensResponseMo: BaseResponse {

    public private(set) var accessToken: String?
    public private(set) var refreshToken: String?

    required public init(map: Map) throws {
        accessToken = try? map.value(Constants.accessToken)
        refreshToken = try? map.value(Constants.refreshToken)

        try super.init(map: map)
    }

    override public func mapping(map: Map) {
        super.mapping(map: map)
        accessToken >>> map[Constants.accessToken]
        refreshToken >>> map[Constants.refreshToken]
    }
}

// MARK: - Constants

fileprivate extension TokensResponseMo {
    enum Constants {
        static let accessToken = "access_token"
        static let refreshToken = "refresh_token"
    }
}

