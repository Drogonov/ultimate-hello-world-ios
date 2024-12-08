//
//  SingUpAPI.swift
//  Services
//
//  Created by Anton Vlezko on 26/11/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import Net
import CommonNet

public protocol SingUpAPIProtocol {
    func singupData(
        request: SingUpRequestMo
    ) async throws -> SingUpResponseMo
}

// MARK: - SingUpAPI

public struct SingUpAPI: BaseAPI {

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

// MARK: - SingUpAPIProtocol

extension SingUpAPI: SingUpAPIProtocol {

    public func singupData(
        request: SingUpRequestMo
    ) async throws -> SingUpResponseMo {
        try await performRequest(
            request: SingUpRequestData(request: request)
        )
    }
}
