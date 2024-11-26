//
//  RefreshTokenRequestData.swift
//  Net
//
//  Created by Anton Vlezko on 26/11/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import CommonNet

struct RefreshTokenRequestData: NetRequestResponseProtocol {
    var method: NetMethod = .post
    var paramsEncoder: NetEncoderProtocol = VoidEncoderForMo()
    var params: [String: Any]? = nil
    var timeout: NetTimeoutProtocol = NetTimeout.normal
    var urlPath: String = "/auth/refresh"
    var headers: NetHeaders = .defaultHeaders(.refreshToken)
    var serializer = UniversalMappableSerializer<TokensResponseMo>()
    var stringUrl: String?
}
