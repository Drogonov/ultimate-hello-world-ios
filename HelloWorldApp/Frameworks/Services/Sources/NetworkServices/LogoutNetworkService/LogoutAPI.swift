//
//  LogoutAPI.swift
//  Services
//
//  Created by Anton Vlezko on 26/11/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import Net
import CommonNet

public protocol LogoutAPIProtocol {
    func logoutData(
        request: LogoutRequestMo
    ) async throws -> LogoutResponseMo
}

// MARK: - LogoutAPI

struct LogoutAPI: BaseAPI {

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

// MARK: - LogoutAPIProtocol

extension LogoutAPI: LogoutAPIProtocol {

    func logoutData(
        request: LogoutRequestMo
    ) async throws -> LogoutResponseMo {
        try await performRequest(
            request: LogoutRequestData(request: request)
        )
    }
}
