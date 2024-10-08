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

struct ___VARIABLE_productName___RequestData: NTRequestResponseProtocol {
    var method: NTMethod = .post
    var paramsEncoder: NTEncoderProtocol = FormURLEncoderForMo()
    var params: [String: Any]? = nil
    var timeout: NTTimeoutProtocol = ACTimeout.normal
    var urlPath: String = "/___VARIABLE_methodName___"
    var headers: NTHeaders = .defaultHeaders()
    var serializer = UniversalMappableSerializer<___VARIABLE_productName___ResponseMo>()
    var stringUrl: String?

    init(request: ___VARIABLE_productName___RequestMo) {
        self.params = request.toJSON()
    }
}
