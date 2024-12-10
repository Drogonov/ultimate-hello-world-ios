//
//  AppAPI.swift
//  Services
//
//  Created by Anton Vlezko on 10/12/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import Net
import CommonNet

// MARK: - AppAPIProtocol

// sourcery: AutoMockable
public protocol AppAPIProtocol {
    func getMoreInfoData(
        request: GetMoreInfoRequestMo
    ) async throws -> GetMoreInfoResponseMo

    func getMagicData(
        request: GetMagicRequestMo
    ) async throws -> GetMagicResponseMo

    func getHelloData(
        request: GetHelloRequestMo
    ) async throws -> GetHelloResponseMo

    func getCountriesData(
        request: GetCountriesRequestMo
    ) async throws -> GetCountriesResponseMo
}

// MARK: - AppAPI

public struct AppAPI: BaseAPI {

    // MARK: Implementations BaseApiMap
    
    public var networkClient: NetworkManagerProtocol
    public var errorHandler: NetErrorHandler

    public init(
        networkClient: NetworkManagerProtocol,
        errorHandler: NetErrorHandler
    ) {
        self.networkClient = networkClient
        self.errorHandler = errorHandler
    }
}

// MARK: - AppAPIProtocol

extension AppAPI: AppAPIProtocol {
    public func getMoreInfoData(
        request: GetMoreInfoRequestMo
    ) async throws -> GetMoreInfoResponseMo {
        try await performRequest(
            request: GetMoreInfoRequestData(request: request)
        )
    }

    public func getMagicData(
        request: GetMagicRequestMo
    ) async throws -> GetMagicResponseMo {
        try await performRequest(
            request: GetMagicRequestData(request: request)
        )
    }

    public func getHelloData(
        request: GetHelloRequestMo
    ) async throws -> GetHelloResponseMo {
        try await performRequest(
            request: GetHelloRequestData(request: request)
        )
    }

    public func getCountriesData(
        request: GetCountriesRequestMo
    ) async throws -> GetCountriesResponseMo {
        try await performRequest(
            request: GetCountriesRequestData(request: request)
        )
    }
}

