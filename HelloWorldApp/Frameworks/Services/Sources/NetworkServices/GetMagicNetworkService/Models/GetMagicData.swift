//
//  GetMagicData.swift
//  Services
//
//  Created by Anton Vlezko on 30/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Net
import CommonNet

struct GetMagicRequestData: NetRequestResponseProtocol {
    var method: NetMethod = .post
    var paramsEncoder: NetEncoderProtocol = FormURLEncoderForMo()
    var params: [String: Any]? = nil
    var timeout: NetTimeoutProtocol = NetTimeout.normal
    var urlPath: String = "/magic"
    var headers: NetHeaders = .defaultHeaders()
    var serializer = UniversalMappableSerializer<GetMagicResponseMo>()
    var stringUrl: String?

    init(request: GetMagicRequestMo) {
        self.params = request.toJSON()
    }
}
