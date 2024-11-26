//
//  ___VARIABLE_requestDataName___.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Net
import CommonNet

struct ___VARIABLE_productName___RequestData: NetRequestResponseProtocol {
    var method: NetMethod = .post
    var paramsEncoder: NetEncoderProtocol = FormURLEncoderForMo()
    var params: [String: Any]? = nil
    var timeout: NetTimeoutProtocol = NetTimeout.normal
    var urlPath: String = "/___VARIABLE_methodName___"
    var headers: NetHeaders = .defaultHeaders()
    var serializer = UniversalMappableSerializer<___VARIABLE_productName___ResponseMo>()
    var stringUrl: String?

    init(request: ___VARIABLE_productName___RequestMo) {
        self.params = request.toJSON()
    }
}
