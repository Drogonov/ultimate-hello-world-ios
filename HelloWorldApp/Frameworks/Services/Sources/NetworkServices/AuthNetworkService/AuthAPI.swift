//
//  AuthAPI.swift
//  Services
//
//  Created by Anton Vlezko on 10/12/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import Net
import CommonNet

// sourcery: AutoMockable
public protocol AuthAPIProtocol {
    func verifyOTPData(
        request: VerifyOTPRequestMo
    ) async throws -> TokensResponseMo

    func singupData(
        request: SingUpRequestMo
    ) async throws -> SingUpResponseMo

    func singInData(
        request: SingInRequestMo
    ) async throws -> TokensResponseMo

    func logoutData() async throws -> LogoutResponseMo
}

// MARK: - AuthAPI

public struct AuthAPI: BaseAPI {

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

// MARK: - AuthAPIProtocol

extension AuthAPI: AuthAPIProtocol {
    public func verifyOTPData(
        request: VerifyOTPRequestMo
    ) async throws -> TokensResponseMo {
        try await performRequest(
            request: VerifyOTPRequestData(request: request)
        )
    }

    public func singupData(
        request: SingUpRequestMo
    ) async throws -> SingUpResponseMo {
        try await performRequest(
            request: SingUpRequestData(request: request)
        )
    }

    public func singInData(
        request: SingInRequestMo
    ) async throws -> TokensResponseMo {
        try await performRequest(
            request: SingInRequestData(request: request)
        )
    }

    public func logoutData() async throws -> LogoutResponseMo {
        try await performRequest(
            request: LogoutRequestData()
        )
    }
}

