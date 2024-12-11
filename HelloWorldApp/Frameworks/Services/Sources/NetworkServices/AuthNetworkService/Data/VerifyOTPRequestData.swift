//
//  VerifyOTPRequestData.swift
//  Services
//
//  Created by Anton Vlezko on 26/11/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import Net
import CommonNet

struct VerifyOTPRequestData: NetRequestResponseProtocol {
    var method: NetMethod = .post
    var paramsEncoder: NetEncoderProtocol = FormURLEncoderForMo()
    var params: [String: Any]? = nil
    var timeout: NetTimeoutProtocol = NetTimeout.normal
    var urlPath: String = "/auth/local/verifyOTP"
    var headers: NetHeaders = .defaultHeaders(nil)
    var serializer = UniversalMappableSerializer<TokensResponseMo>()
    var stringUrl: String?

    init(request: AuthRequestMo) {
        self.params = request.toJSON()
    }
}
