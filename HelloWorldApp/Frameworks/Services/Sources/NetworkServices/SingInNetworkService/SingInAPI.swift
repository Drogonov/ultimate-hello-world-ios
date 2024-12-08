//
//  SingInAPI.swift
//  Services
//
//  Created by Anton Vlezko on 26/11/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import Net
import CommonNet

public protocol SingInAPIProtocol {
    func singInData(
        request: SingInRequestMo
    ) async throws -> TokensResponseMo
}

// MARK: - SingInAPI

public struct SingInAPI: BaseAPI {

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

// MARK: - SingInAPIProtocol

extension SingInAPI: SingInAPIProtocol {

    public func singInData(
        request: SingInRequestMo
    ) async throws -> TokensResponseMo {
        try await performRequest(
            request: SingInRequestData(request: request)
        )
    }
}
