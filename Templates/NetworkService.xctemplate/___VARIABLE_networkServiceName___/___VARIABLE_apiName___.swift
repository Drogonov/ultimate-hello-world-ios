//
//  ___VARIABLE_apiName___.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Net
import CommonNet

public protocol ___VARIABLE_productName___APIProtocol {
    func ___VARIABLE_methodName___Data(
        request: ___VARIABLE_productName___RequestMo
    ) async throws -> ___VARIABLE_productName___ResponseMo
}

// MARK: - ___VARIABLE_productName___API

struct ___VARIABLE_productName___API: BaseAPI {

    // MARK: Implementations BaseApiMap
    var networkClient: NetworkManagerProtocol
    var errorHandler: NetErrorHandler

    init(
        networkClient: NetworkManagerProtocol,
        errorHandler: NetErrorHandler
    ) {
        self.networkClient = networkClient
        self.errorHandler = errorHandler
    }
}

// MARK: - ___VARIABLE_productName___APIProtocol

extension ___VARIABLE_productName___API: ___VARIABLE_productName___APIProtocol {

    func ___VARIABLE_methodName___Data(
        request: ___VARIABLE_productName___RequestMo
    ) async throws -> ___VARIABLE_productName___ResponseMo {
        try await performRequest(
            request: ___VARIABLE_productName___RequestData(request: request)
        )
    }
}
