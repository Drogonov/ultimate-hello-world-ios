//
//  GetCountriesNetworkService.swift
//  Services
//
//  Created by Anton Vlezko on 30/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Net
import Persistence
import CommonNet

// MARK: - GetCountriesServiceProtocol

// sourcery: AutoMockable
public protocol GetCountriesNetworkServiceProtocol {
    func getCountriesData(
        request: GetCountriesRequestMo,
        forceRequest: Bool
    ) async throws -> GetCountriesResponseMo
}

// MARK: - GetCountriesService

public final class GetCountriesNetworkService {

    // MARK: Private properties

    fileprivate let api: GetCountriesAPIProtocol
    fileprivate let shortCacher: CacheProtocol?

    // MARK: Init

    public init(
        api: GetCountriesAPIProtocol,
        shortCacher: CacheProtocol?
    ) {
        self.api = api
        self.shortCacher = shortCacher
    }
}

// MARK: - GetCountriesNetworkServiceProtocol

extension GetCountriesNetworkService: GetCountriesNetworkServiceProtocol {
    public func getCountriesData(
        request: GetCountriesRequestMo,
        forceRequest: Bool
    ) async throws -> GetCountriesResponseMo {
        let metaInfo = MetaInfo(
            cacheKey: NetworkServiceCacheKey.getCountries,
            forceRequest: true
        )

        let response = try await NetworkCoordinator.proceed(metaInfo: metaInfo) {
            try await api.getCountriesData(request: request)
        }

        return response
    }
}

