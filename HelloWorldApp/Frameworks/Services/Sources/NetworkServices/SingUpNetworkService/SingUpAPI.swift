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

struct SingUpAPI: BaseAPI {

    // MARK: Implementations BaseApiMap
    var networkClient: NetworkManagerProtocol
    var errorHandler: NetErrorHandler

    init(
        networkClient: NetworkManagerProtocol,
        errorHandler: NetErrorHandler
    ) {
        self.networkClient = networkClient
        self.errorHandler = errorHandler
    }
}

// MARK: - SingUpAPIProtocol

extension SingUpAPI: SingUpAPIProtocol {

    func singupData(
        request: SingUpRequestMo
    ) async throws -> SingUpResponseMo {
        try await performRequest(
            request: SingUpRequestData(request: request)
        )
    }
}
