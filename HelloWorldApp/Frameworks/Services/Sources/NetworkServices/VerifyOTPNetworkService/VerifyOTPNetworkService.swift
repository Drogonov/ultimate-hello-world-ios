//
//  VerifyOTPNetworkService.swift
//  Services
//
//  Created by Anton Vlezko on 26/11/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import Net
import Persistence
import CommonNet

// MARK: - VerifyOTPServiceProtocol

// sourcery: AutoMockable
public protocol VerifyOTPNetworkServiceProtocol {
    func verifyOTPData(
        request: VerifyOTPRequestMo,
        forceRequest: Bool
    ) async throws -> TokensResponseMo
}

// MARK: - VerifyOTPService

final class VerifyOTPNetworkService {

    // MARK: Private properties

    fileprivate let api: VerifyOTPAPIProtocol
    fileprivate let shortCacher: CacheProtocol?

    // MARK: Init

    init(
        api: VerifyOTPAPIProtocol,
        shortCacher: CacheProtocol?
    ) {
        self.api = api
        self.shortCacher = shortCacher
    }
}

// MARK: - VerifyOTPNetworkServiceProtocol

extension VerifyOTPNetworkService: VerifyOTPNetworkServiceProtocol {
    func verifyOTPData(
        request: VerifyOTPRequestMo,
        forceRequest: Bool
    ) async throws -> TokensResponseMo {
        let metaInfo = MetaInfo(
            cacheKey: NetworkServiceCacheKey.verifyOTP,
            forceRequest: true
        )

        let response = try await NetworkCoordinator.proceed(metaInfo: metaInfo) {
            try await api.verifyOTPData(request: request)
        }

        return response
    }
}

