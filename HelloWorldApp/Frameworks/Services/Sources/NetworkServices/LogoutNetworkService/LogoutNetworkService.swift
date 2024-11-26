//
//  LogoutNetworkService.swift
//  Services
//
//  Created by Anton Vlezko on 26/11/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import Net
import Persistence
import CommonNet

// MARK: - LogoutServiceProtocol

// sourcery: AutoMockable
public protocol LogoutNetworkServiceProtocol {
    func logoutData(
        request: LogoutRequestMo,
        forceRequest: Bool
    ) async throws -> LogoutResponseMo
}

// MARK: - LogoutService

final class LogoutNetworkService {

    // MARK: Private properties

    fileprivate let api: LogoutAPIProtocol
    fileprivate let shortCacher: CacheProtocol?

    // MARK: Init

    init(
        api: LogoutAPIProtocol,
        shortCacher: CacheProtocol?
    ) {
        self.api = api
        self.shortCacher = shortCacher
    }
}

// MARK: - LogoutNetworkServiceProtocol

extension LogoutNetworkService: LogoutNetworkServiceProtocol {
    func logoutData(
        request: LogoutRequestMo,
        forceRequest: Bool
    ) async throws -> LogoutResponseMo {
        let metaInfo = MetaInfo(
            cacheKey: NetworkServiceCacheKey.logout,
            forceRequest: true
        )

        let response = try await NetworkCoordinator.proceed(metaInfo: metaInfo) {
            try await api.logoutData(request: request)
        }

        return response
    }
}

