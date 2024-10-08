//
//  GetCountriesAPI.swift
//  Services
//
//  Created by Anton Vlezko on 30/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Net
import CommonNet

// sourcery: AutoMockable
public protocol GetCountriesAPIProtocol {
    func getCountriesData(
        request: GetCountriesRequestMo
    ) async throws -> GetCountriesResponseMo
}

// MARK: - GetCountriesAPI

public struct GetCountriesAPI: BaseAPI {

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

// MARK: - GetCountriesAPIProtocol

extension GetCountriesAPI: GetCountriesAPIProtocol {

    public func getCountriesData(
        request: GetCountriesRequestMo
    ) async throws -> GetCountriesResponseMo {
        try await performRequest(
            request: GetCountriesRequestData(request: request)
        )
    }
}
