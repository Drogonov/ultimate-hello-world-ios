//
//  SingInNetworkService.swift
//  Services
//
//  Created by Anton Vlezko on 26/11/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import Net
import Persistence
import CommonNet

// MARK: - SingInServiceProtocol

// sourcery: AutoMockable
public protocol SingInNetworkServiceProtocol {
    func singInData(
        request: SingInRequestMo,
        forceRequest: Bool
    ) async throws -> TokensResponseMo
}

// MARK: - SingInService

final class SingInNetworkService {

    // MARK: Private properties

    fileprivate let api: SingInAPIProtocol
    fileprivate let shortCacher: CacheProtocol?

    // MARK: Init

    init(
        api: SingInAPIProtocol,
        shortCacher: CacheProtocol?
    ) {
        self.api = api
        self.shortCacher = shortCacher
    }
}

// MARK: - SingInNetworkServiceProtocol

extension SingInNetworkService: SingInNetworkServiceProtocol {
    func singInData(
        request: SingInRequestMo,
        forceRequest: Bool
    ) async throws -> TokensResponseMo {
        let metaInfo = MetaInfo(
            cacheKey: NetworkServiceCacheKey.singin,
            forceRequest: true
        )

        let response = try await NetworkCoordinator.proceed(metaInfo: metaInfo) {
            try await api.singInData(request: request)
        }

        return response
    }
}

