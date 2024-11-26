//
//  SingInRequestData.swift
//  Services
//
//  Created by Anton Vlezko on 26/11/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import Net
import CommonNet

struct SingInRequestData: NetRequestResponseProtocol {
    var method: NetMethod = .post
    var paramsEncoder: NetEncoderProtocol = FormURLEncoderForMo()
    var params: [String: Any]? = nil
    var timeout: NetTimeoutProtocol = NetTimeout.normal
    var urlPath: String = "/singIn"
    var headers: NetHeaders = .defaultHeaders()
    var serializer = UniversalMappableSerializer<TokensResponseMo>()
    var stringUrl: String?

    init(request: SingInRequestMo) {
        self.params = request.toJSON()
    }
}
