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
    var paramsEncoder: NetEncoderProtocol = VoidEncoderForMo()
    var params: Codable? = nil
    var timeout: NetTimeoutProtocol = NetTimeout.normal
    var urlPath: String = "/auth/logout"
    var headers: NetHeaders = .defaultHeaders(.refreshToken)
    var serializer = UniversalMappableSerializer<StatusResponseMo>()
    var stringUrl: String?
}
