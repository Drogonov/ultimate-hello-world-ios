//
//  LogoutRequestData.swift
//  Services
//
//  Created by Anton Vlezko on 26/11/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import Net
import CommonNet

struct LogoutRequestData: NetRequestResponseProtocol {
    var method: NetMethod = .post
    var paramsEncoder: NetEncoderProtocol = FormURLEncoderForMo()
    var params: [String: Any]? = nil
    var timeout: NetTimeoutProtocol = NetTimeout.normal
    var urlPath: String = "/logout"
    var headers: NetHeaders = .defaultHeaders()
    var serializer = UniversalMappableSerializer<LogoutResponseMo>()
    var stringUrl: String?

    init(request: LogoutRequestMo) {
        self.params = request.toJSON()
    }
}
