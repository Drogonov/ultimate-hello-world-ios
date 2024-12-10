//
//  GetHelloRequestData.swift
//  Services
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Net
import CommonNet

struct GetHelloRequestData: NetRequestResponseProtocol {
    var method: NetMethod = .post
    var paramsEncoder: NetEncoderProtocol = FormURLEncoderForMo()
    var params: [String: Any]? = nil
    var timeout: NetTimeoutProtocol = NetTimeout.normal
    var urlPath: String = "/app/hello"
    var headers: NetHeaders = .defaultHeaders()
    var serializer = UniversalMappableSerializer<GetHelloResponseMo>()
    var stringUrl: String?

    init(request: GetHelloRequestMo) {
        self.params = request.toJSON()
    }
}
