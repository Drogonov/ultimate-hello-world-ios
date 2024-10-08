//
//  GetMoreInfoNetworkService.swift
//  Services
//
//  Created by Anton Vlezko on 30/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Net
import Persistence
import CommonNet

// MARK: - GetMoreInfoServiceProtocol

// sourcery: AutoMockable
public protocol GetMoreInfoNetworkServiceProtocol {
    func getMoreInfoData(
        request: GetMoreInfoRequestMo,
        forceRequest: Bool
    ) async throws -> GetMoreInfoResponseMo
}

// MARK: - GetMoreInfoService

final public class GetMoreInfoNetworkService {

    // MARK: Private properties

    fileprivate let api: GetMoreInfoAPIProtocol
    fileprivate let shortCacher: CacheProtocol?

    // MARK: Init

    public init(
        api: GetMoreInfoAPIProtocol,
        shortCacher: CacheProtocol?
    ) {
        self.api = api
        self.shortCacher = shortCacher
    }
}

// MARK: - GetMoreInfoNetworkServiceProtocol

extension GetMoreInfoNetworkService: GetMoreInfoNetworkServiceProtocol {
    public func getMoreInfoData(
        request: GetMoreInfoRequestMo,
        forceRequest: Bool
    ) async throws -> GetMoreInfoResponseMo {
        let metaInfo = MetaInfo(
            cacheKey: NetworkServiceCacheKey.getInfo,
            forceRequest: true
        )

        let response = try await NetworkCoordinator.proceed(metaInfo: metaInfo) {
            try await api.getMoreInfoData(request: request)
        }

        return response
    }
}

