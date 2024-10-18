//
//  GetHelloAPI.swift
//  Services
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Net
import CommonNet

public protocol GetHelloAPIProtocol {
    func getHelloData(
        request: GetHelloRequestMo
    ) async throws -> GetHelloResponseMo
}

// MARK: - GetHelloDataAPI

public struct GetHelloAPI: BaseAPI {

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

// MARK: - GetHelloDataAPIProtocol

extension GetHelloAPI: GetHelloAPIProtocol {

    public func getHelloData(
        request: GetHelloRequestMo
    ) async throws -> GetHelloResponseMo {
        try await performRequest(
            request: GetHelloRequestData(request: request)
        )
    }
}
