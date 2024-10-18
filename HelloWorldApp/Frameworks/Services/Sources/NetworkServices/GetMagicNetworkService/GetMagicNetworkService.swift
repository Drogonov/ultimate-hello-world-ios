//
//  GetMagicNetworkService.swift
//  Services
//
//  Created by Anton Vlezko on 30/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Net
import CommonNet
import Persistence

// MARK: - GetMagicServiceProtocol

// sourcery: AutoMockable
public protocol GetMagicNetworkServiceProtocol {
    func getMagicData(
        request: GetMagicRequestMo,
        forceRequest: Bool
    ) async throws -> GetMagicResponseMo
}

// MARK: - GetMagicService

public final class GetMagicNetworkService {

    // MARK: Private properties

    fileprivate let api: GetMagicAPIProtocol
    fileprivate let shortCacher: CacheProtocol?

    // MARK: Init

    public init(
        api: GetMagicAPIProtocol,
        shortCacher: CacheProtocol?
    ) {
        self.api = api
        self.shortCacher = shortCacher
    }
}

// MARK: - GetMagicNetworkServiceProtocol

extension GetMagicNetworkService: GetMagicNetworkServiceProtocol {
    public func getMagicData(
        request: GetMagicRequestMo,
        forceRequest: Bool
    ) async throws -> GetMagicResponseMo {
        let metaInfo = MetaInfo(
            cacheKey: NetworkServiceCacheKey.getMagic,
            forceRequest: true
        )

        let response = try await NetworkCoordinator.proceed(metaInfo: metaInfo) {
            try await api.getMagicData(request: request)
        }

        return response
    }
}

