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
        request: AuthRequestMo
    ) async throws -> TokensResponseMo

    func resendOTPData(
        request: AuthRequestMo
    ) async throws -> TokensResponseMo

    func singUpData(
        request: AuthRequestMo
    ) async throws -> StatusResponseMo

    func singInData(
        request: AuthRequestMo
    ) async throws -> TokensResponseMo

    func logoutData() async throws -> StatusResponseMo
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
        request: AuthRequestMo
    ) async throws -> TokensResponseMo {
        try await performRequest(
            request: VerifyOTPRequestData(request: request)
        )
    }

    public func resendOTPData(
        request: AuthRequestMo
    ) async throws -> TokensResponseMo {
        try await performRequest(
            request: ResendOTPRequestData(request: request)
        )
    }

    public func singUpData(
        request: AuthRequestMo
    ) async throws -> StatusResponseMo {
        try await performRequest(
            request: SingUpRequestData(request: request)
        )
    }

    public func singInData(
        request: AuthRequestMo
    ) async throws -> TokensResponseMo {
        try await performRequest(
            request: SingInRequestData(request: request)
        )
    }

    public func logoutData() async throws -> StatusResponseMo {
        try await performRequest(
            request: LogoutRequestData()
        )
    }
}

