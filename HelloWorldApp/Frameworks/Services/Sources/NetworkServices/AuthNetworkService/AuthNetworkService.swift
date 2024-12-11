//
//  AuthNetworkService.swift
//  Services
//
//  Created by Anton Vlezko on 10/12/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import Net
import Persistence
import CommonNet

// MARK: - AuthNetworkServiceProtocol

// sourcery: AutoMockable
public protocol AuthNetworkServiceProtocol {
    func verifyOTPData(
        request: AuthRequestMo,
        forceRequest: Bool
    ) async throws -> TokensResponseMo

    func resendOTPData(
        request: AuthRequestMo,
        forceRequest: Bool
    ) async throws -> TokensResponseMo

    func singUpData(
        request: AuthRequestMo,
        forceRequest: Bool
    ) async throws -> StatusResponseMo

    func singInData(
        request: AuthRequestMo,
        forceRequest: Bool
    ) async throws -> TokensResponseMo

    func logoutData(
        forceRequest: Bool
    ) async throws -> StatusResponseMo

    func doesErrorFieldsContainsText(errorFields: [ErrorDetailMo]?, field: SingInErrorFields) -> String?
}

// MARK: - AuthNetworkService

public final class AuthNetworkService {

    // MARK: Private properties

    fileprivate let api: AuthAPIProtocol
    fileprivate let shortCacher: CacheProtocol?

    // MARK: Init

    public init(
        api: AuthAPIProtocol,
        shortCacher: CacheProtocol?
    ) {
        self.api = api
        self.shortCacher = shortCacher
    }
}

// MARK: - AuthNetworkServiceProtocol

extension AuthNetworkService: AuthNetworkServiceProtocol {
    public func verifyOTPData(
        request: AuthRequestMo,
        forceRequest: Bool
    ) async throws -> TokensResponseMo {
        let metaInfo = MetaInfo(
            cacheKey: NetworkServiceCacheKey.verifyOTP,
            forceRequest: true
        )

        let response = try await NetworkCoordinator.proceed(metaInfo: metaInfo) {
            try await api.verifyOTPData(request: request)
        }

        return response
    }

    public func resendOTPData(
        request: AuthRequestMo,
        forceRequest: Bool
    ) async throws -> TokensResponseMo {
        let metaInfo = MetaInfo(
            cacheKey: NetworkServiceCacheKey.resendOTP,
            forceRequest: true
        )

        let response = try await NetworkCoordinator.proceed(metaInfo: metaInfo) {
            try await api.resendOTPData(request: request)
        }

        return response
    }

    public func singUpData(
        request: AuthRequestMo,
        forceRequest: Bool
    ) async throws -> StatusResponseMo {
        let metaInfo = MetaInfo(
            cacheKey: NetworkServiceCacheKey.singUp,
            forceRequest: true
        )

        let response = try await NetworkCoordinator.proceed(metaInfo: metaInfo) {
            try await api.singUpData(request: request)
        }

        return response
    }

    public func singInData(
        request: AuthRequestMo,
        forceRequest: Bool
    ) async throws -> TokensResponseMo {
        let metaInfo = MetaInfo(
            cacheKey: NetworkServiceCacheKey.singIn,
            forceRequest: true
        )

        let response = try await NetworkCoordinator.proceed(metaInfo: metaInfo) {
            try await api.singInData(request: request)
        }

        return response
    }

    public func logoutData(
        forceRequest: Bool
    ) async throws -> StatusResponseMo {
        let metaInfo = MetaInfo(
            cacheKey: NetworkServiceCacheKey.logout,
            forceRequest: true
        )

        let response = try await NetworkCoordinator.proceed(metaInfo: metaInfo) {
            try await api.logoutData()
        }

        return response
    }

    public func doesErrorFieldsContainsText(errorFields: [ErrorDetailMo]?, field: SingInErrorFields) -> String? {
        errorFields?.first(where: { error in
            findServerError(from: error.fieldCode) == field
        })?.errorMsg
    }
}

// MARK: - Private Methods

private extension AuthNetworkService {
    func findServerError(from errorSubCode: String) -> SingInErrorFields? {
        SingInErrorFields(rawValue: errorSubCode)
    }
}
