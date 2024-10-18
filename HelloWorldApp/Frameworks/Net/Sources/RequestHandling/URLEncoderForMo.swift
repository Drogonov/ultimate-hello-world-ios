//
//  URLEncoderForMo.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import ObjectMapper
import CommonNet

// MARK: - URLEncoderForMo

public class URLEncoderForMo {

    // MARK: Private Properties

    private let transform: [String: ArrayTransformType]?

    //  MARK: Init

    public init(
        transform: [String: ArrayTransformType]? = nil
    ) {
        self.transform = transform
    }

    // MARK: URLEncoderForMoError enum

    public enum URLEncoderForMoError: Error {
        case unableToParseParameters
        case unableToGetUrl
    }
}

// MARK: - NetEncoderProtocol

extension URLEncoderForMo: NetEncoderProtocol {

    public func encode<T>(_ value: T, request: inout URLRequest) throws {

        guard let requestUrl = request.url else {
            throw ApiError.prepareLayerError(URLEncoderForMoError.unableToGetUrl)
        }

        guard let dict = value as? [String: Any] else {
            throw ApiError.prepareLayerError(URLEncoderForMoError.unableToParseParameters)
        }

        if var urlComponents = URLComponents(url: requestUrl, resolvingAgainstBaseURL: false) {
            let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { "\($0)&" } ?? .empty)
            + DictionarySerializer.serializeFor(
                dict,
                transform: transform,
                urlEncoding: true
            )

            urlComponents.percentEncodedQuery = percentEncodedQuery
            request.url = urlComponents.url
        }
    }
}
