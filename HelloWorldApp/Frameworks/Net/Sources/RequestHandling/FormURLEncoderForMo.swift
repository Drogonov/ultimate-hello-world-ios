//
//  FormURLEncoderForMo.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import ObjectMapper
import CommonNet

// MARK: - FormURLEncoderForMo class

public class FormURLEncoderForMo: NetEncoderProtocol {

    // MARK: Private Properties

    private let transform: [String: ArrayTransformType]?
    private let urlEncoding: Bool

    //  MARK: Init

    public init(
        transform: [String: ArrayTransformType]? = nil,
        urlEncoding: Bool = false
    ) {
        self.transform = transform
        self.urlEncoding = urlEncoding
    }

    // MARK: FormURLEncoderForMoError enum

    enum FormURLEncoderForMoError: Error {
        case unableToCast
    }

    // MARK: NetEncoderProtocol implementation

    public func encode<T>(_ value: T, request: inout URLRequest) throws {
        modifyRequest(urlRequest: &request)

        guard let dict = value as? [String: Any] else {
            throw ApiError.prepareLayerError(FormURLEncoderForMoError.unableToCast)
        }

        request.httpBody = DictionarySerializer.serializeFor(
            dict,
            transform: transform,
            urlEncoding: urlEncoding
        )
        .data(using: .utf8, allowLossyConversion: false)
    }

    // MARK: Private methods

    private func modifyRequest(urlRequest: inout URLRequest) {
        urlRequest.allHTTPHeaderFields?["Content-Type"] = "application/x-www-form-urlencoded; charset=utf-8"
    }
}
