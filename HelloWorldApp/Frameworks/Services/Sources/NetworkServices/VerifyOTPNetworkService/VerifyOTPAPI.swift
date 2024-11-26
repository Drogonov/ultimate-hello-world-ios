//
//  VerifyOTPAPI.swift
//  Services
//
//  Created by Anton Vlezko on 26/11/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import Net
import CommonNet

public protocol VerifyOTPAPIProtocol {
    func verifyOTPData(
        request: VerifyOTPRequestMo
    ) async throws -> TokensResponseMo
}

// MARK: - VerifyOTPAPI

struct VerifyOTPAPI: BaseAPI {

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

// MARK: - VerifyOTPAPIProtocol

extension VerifyOTPAPI: VerifyOTPAPIProtocol {

    func verifyOTPData(
        request: VerifyOTPRequestMo
    ) async throws -> TokensResponseMo {
        try await performRequest(
            request: VerifyOTPRequestData(request: request)
        )
    }
}
