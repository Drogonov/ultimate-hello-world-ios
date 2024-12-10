//
//  SingUpRequestData.swift
//  Services
//
//  Created by Anton Vlezko on 26/11/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import Net
import CommonNet

struct SingUpRequestData: NetRequestResponseProtocol {
    var method: NetMethod = .post
    var paramsEncoder: NetEncoderProtocol = FormURLEncoderForMo()
    var params: [String: Any]? = nil
    var timeout: NetTimeoutProtocol = NetTimeout.normal
    var urlPath: String = "/auth/local/signup"
    var headers: NetHeaders = .defaultHeaders(nil)
    var serializer = UniversalMappableSerializer<SingUpResponseMo>()
    var stringUrl: String?

    init(request: SingUpRequestMo) {
        self.params = request.toJSON()
    }
}
