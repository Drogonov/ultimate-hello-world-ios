//
//  GetMoreInfoRequestData.swift
//  Services
//
//  Created by Anton Vlezko on 30/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Net
import CommonNet

struct GetMoreInfoRequestData: NetRequestResponseProtocol {
    var method: NetMethod = .post
    var paramsEncoder: NetEncoderProtocol = FormURLEncoderForMo()
    var params: [String: Any]? = nil
    var timeout: NetTimeoutProtocol = NetTimeout.normal
    var urlPath: String = "/app/info"
    var headers: NetHeaders = .defaultHeaders()
    var serializer = UniversalMappableSerializer<GetMoreInfoResponseMo>()
    var stringUrl: String?

    init(request: GetMoreInfoRequestMo) {
        self.params = request.toJSON()
    }
}
