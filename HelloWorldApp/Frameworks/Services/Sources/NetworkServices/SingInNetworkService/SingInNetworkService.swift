//
//  SingInNetworkService.swift
//  Services
//
//  Created by Anton Vlezko on 26/11/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import Net
import Persistence
import CommonNet

// MARK: - SingInServiceProtocol

// sourcery: AutoMockable
public protocol SingInNetworkServiceProtocol {
    func singInData(
        request: SingInRequestMo,
        forceRequest: Bool
    ) async throws -> TokensResponseMo

    func doesErrorFieldsContainsText(errorFields: [ErrorDetailMo]?, field: SingInErrorFields) -> String?
}

// MARK: - SingInService

public final class SingInNetworkService {

    // MARK: Private properties

    fileprivate let api: SingInAPIProtocol
    fileprivate let shortCacher: CacheProtocol?

    // MARK: Init

    public init(
        api: SingInAPIProtocol,
        shortCacher: CacheProtocol?
    ) {
        self.api = api
        self.shortCacher = shortCacher
    }
}

// MARK: - SingInNetworkServiceProtocol

extension SingInNetworkService: SingInNetworkServiceProtocol {
    public func singInData(
        request: SingInRequestMo,
        forceRequest: Bool
    ) async throws -> TokensResponseMo {
        let metaInfo = MetaInfo(
            cacheKey: NetworkServiceCacheKey.singin,
            forceRequest: true
        )

        let response = try await NetworkCoordinator.proceed(metaInfo: metaInfo) {
            try await api.singInData(request: request)
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

private extension SingInNetworkService {
    func findServerError(from errorSubCode: String) -> SingInErrorFields? {
        SingInErrorFields(rawValue: errorSubCode)
    }
}
