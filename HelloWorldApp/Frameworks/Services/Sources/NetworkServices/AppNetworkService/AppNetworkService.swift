//
//  AppNetworkService.swift
//  Services
//
//  Created by Anton Vlezko on 10/12/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import Net
import Persistence
import CommonNet

// MARK: - AppNetworkServiceProtocol

// sourcery: AutoMockable
public protocol AppNetworkServiceProtocol {
    func getMoreInfoData(
        request: GetMoreInfoRequestMo,
        forceRequest: Bool
    ) async throws -> GetMoreInfoResponseMo

    func getMagicData(
        request: GetMagicRequestMo,
        forceRequest: Bool
    ) async throws -> GetMagicResponseMo

    func getHelloData(
        request: GetHelloRequestMo,
        forceRequest: Bool
    ) async throws -> GetHelloResponseMo

    func getCountriesData(
        request: GetCountriesRequestMo,
        forceRequest: Bool
    ) async throws -> GetCountriesResponseMo
}

// MARK: - AppNetworkService

final public class AppNetworkService {

    // MARK: Private properties

    fileprivate let api: AppAPIProtocol
    fileprivate let shortCacher: CacheProtocol?

    // MARK: Init

    public init(
        api: AppAPIProtocol,
        shortCacher: CacheProtocol?
    ) {
        self.api = api
        self.shortCacher = shortCacher
    }
}

// MARK: - AppNetworkServiceProtocol

extension AppNetworkService: AppNetworkServiceProtocol {
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
