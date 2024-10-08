//
//  GetMagicAPI.swift
//  Services
//
//  Created by Anton Vlezko on 30/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Net
import CommonNet

public protocol GetMagicAPIProtocol {
    func getMagicData(
        request: GetMagicRequestMo
    ) async throws -> GetMagicResponseMo
}

// MARK: - GetMagicAPI

public struct GetMagicAPI: BaseAPI {

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

// MARK: - GetMagicAPIProtocol

extension GetMagicAPI: GetMagicAPIProtocol {

    public func getMagicData(
        request: GetMagicRequestMo
    ) async throws -> GetMagicResponseMo {
        try await performRequest(
            request: GetMagicRequestData(request: request)
        )
    }
}
