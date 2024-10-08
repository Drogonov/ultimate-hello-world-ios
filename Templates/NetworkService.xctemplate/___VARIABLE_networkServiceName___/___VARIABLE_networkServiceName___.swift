//
//  ___VARIABLE_networkServiceName___.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Net
import Persistence
import CommonNet

// MARK: - ___VARIABLE_productName___ServiceProtocol

// sourcery: AutoMockable
public protocol ___VARIABLE_productName___NetworkServiceProtocol {
    func ___VARIABLE_methodName___Data(
        request: ___VARIABLE_productName___RequestMo,
        forceRequest: Bool
    ) async throws -> ___VARIABLE_productName___ResponseMo
}

// MARK: - ___VARIABLE_productName___Service

final class ___VARIABLE_productName___NetworkService {

    // MARK: Private properties

    fileprivate let api: ___VARIABLE_productName___APIProtocol
    fileprivate let shortCacher: CacheProtocol?

    // MARK: Init

    init(
        api: ___VARIABLE_productName___APIProtocol,
        shortCacher: CacheProtocol?
    ) {
        self.api = api
        self.shortCacher = shortCacher
    }
}

// MARK: - ___VARIABLE_productName___NetworkServiceProtocol

extension ___VARIABLE_productName___NetworkService: ___VARIABLE_productName___NetworkServiceProtocol {
    func ___VARIABLE_methodName___Data(
        request: ___VARIABLE_productName___RequestMo,
        forceRequest: Bool
    ) async throws -> ___VARIABLE_productName___ResponseMo {
        let metaInfo = MetaInfo(
            cacheKey: NetworkServiceCacheKey.___VARIABLE_methodName___,
            forceRequest: true
        )

        let response = try await NetworkCoordinator.proceed(metaInfo: metaInfo) {
            try await api.___VARIABLE_methodName___Data(request: request)
        }

        return response
    }
}

