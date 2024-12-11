//
//  ResendOTPRequestData.swift
//  Services
//
//  Created by Anton Vlezko on 11/12/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import Net
import CommonNet

struct ResendOTPRequestData: NetRequestResponseProtocol {
    var method: NetMethod = .post
    var paramsEncoder: NetEncoderProtocol = FormURLEncoderForMo()
    var params: [String: Any]? = nil
    var timeout: NetTimeoutProtocol = NetTimeout.normal
    var urlPath: String = "/auth/local/resendOTP"
    var headers: NetHeaders = .defaultHeaders(nil)
    var serializer = UniversalMappableSerializer<TokensResponseMo>()
    var stringUrl: String?

    init(request: AuthRequestMo) {
        self.params = request.toJSON()
    }
}
