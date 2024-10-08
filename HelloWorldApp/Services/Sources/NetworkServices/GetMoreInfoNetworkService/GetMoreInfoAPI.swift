//
//  GetMoreInfoAPI.swift
//  Services
//
//  Created by Anton Vlezko on 30/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Net
import CommonNet

public protocol GetMoreInfoAPIProtocol {
    func getMoreInfoData(
        request: GetMoreInfoRequestMo
    ) async throws -> GetMoreInfoResponseMo
}

// MARK: - GetMoreInfoAPI

public struct GetMoreInfoAPI: BaseAPI {

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

// MARK: - GetMoreInfoAPIProtocol

extension GetMoreInfoAPI: GetMoreInfoAPIProtocol {

    public func getMoreInfoData(
        request: GetMoreInfoRequestMo
    ) async throws -> GetMoreInfoResponseMo {
        try await performRequest(
            request: GetMoreInfoRequestData(request: request)
        )
    }
}
