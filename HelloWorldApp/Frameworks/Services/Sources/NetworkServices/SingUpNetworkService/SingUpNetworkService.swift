//
//  SingUpNetworkService.swift
//  Services
//
//  Created by Anton Vlezko on 26/11/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import Net
import Persistence
import CommonNet

// MARK: - SingUpServiceProtocol

// sourcery: AutoMockable
public protocol SingUpNetworkServiceProtocol {
    func singupData(
        request: SingUpRequestMo,
        forceRequest: Bool
    ) async throws -> SingUpResponseMo
}

// MARK: - SingUpService

public final class SingUpNetworkService {

    // MARK: Private properties

    fileprivate let api: SingUpAPIProtocol
    fileprivate let shortCacher: CacheProtocol?

    // MARK: Init

    public init(
        api: SingUpAPIProtocol,
        shortCacher: CacheProtocol?
    ) {
        self.api = api
        self.shortCacher = shortCacher
    }
}

// MARK: - SingUpNetworkServiceProtocol

extension SingUpNetworkService: SingUpNetworkServiceProtocol {
    public func singupData(
        request: SingUpRequestMo,
        forceRequest: Bool
    ) async throws -> SingUpResponseMo {
        let metaInfo = MetaInfo(
            cacheKey: NetworkServiceCacheKey.singup,
            forceRequest: true
        )

        let response = try await NetworkCoordinator.proceed(metaInfo: metaInfo) {
            try await api.singupData(request: request)
        }

        return response
    }
}

