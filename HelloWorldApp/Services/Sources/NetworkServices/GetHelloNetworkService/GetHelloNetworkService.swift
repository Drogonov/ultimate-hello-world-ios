//
//  GetHelloNetworkService.swift
//  Services
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Net
import Persistence
import CommonNet

// MARK: - GetHelloDataServiceProtocol

// sourcery: AutoMockable
public protocol GetHelloNetworkServiceProtocol {
    func getHelloData(
        request: GetHelloRequestMo,
        forceRequest: Bool
    ) async throws -> GetHelloResponseMo
}

// MARK: - GetHelloDataService

public final class GetHelloNetworkService {

    // MARK: Private properties

    fileprivate let api: GetHelloAPIProtocol
    fileprivate let shortCacher: CacheProtocol?

    // MARK: Init

    public init(
        api: GetHelloAPIProtocol,
        shortCacher: CacheProtocol?
    ) {
        self.api = api
        self.shortCacher = shortCacher
    }
}

// MARK: - GetHelloDataNetworkServiceProtocol

extension GetHelloNetworkService: GetHelloNetworkServiceProtocol {
    public func getHelloData(
        request: GetHelloRequestMo,
        forceRequest: Bool
    ) async throws -> GetHelloResponseMo {
        let metaInfo = MetaInfo(
            cacheKey: NetworkServiceCacheKey.getHello,
            forceRequest: true
        )

        let response = try await NetworkCoordinator.proceed(metaInfo: metaInfo) {
            try await api.getHelloData(request: request)
        }

        return response
    }
}
