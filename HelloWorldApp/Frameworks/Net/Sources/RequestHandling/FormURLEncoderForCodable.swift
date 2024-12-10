//
//  FormURLEncoderForCodable.swift
//  Net
//
//  Created by Anton Vlezko on 10/12/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import CommonNet
import Foundation

// MARK: - FormURLEncoderForCodable

public final class FormURLEncoderForCodable: NetEncoderProtocol {

    // MARK: Private Properties

    private let transform: [String: ArrayTransformType]?

    //  MARK: Init

    public init(
        transform: [String: ArrayTransformType]? = nil
    ) {
        self.transform = transform
    }

    // MARK: - FormURLEncoderForCodableError enum

    enum FormURLEncoderForCodableError: Error {
        case unableToCast
    }

    // MARK: - NTEncoderProtocol implementation

    public func encode<T>(_ value: T, request: inout URLRequest) throws {
        modifyRequest(urlRequest: &request)

        let wrappedModel = AnyEncodable(value)

        guard
            let jsonData = try? JSONEncoder().encode(wrappedModel),
            let dict = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
        else {
            throw FormURLEncoderForCodableError.unableToCast
        }

        request.httpBody = DictionarySerializer.serializeFor(dict, transform: transform).data(
            using: .utf8, allowLossyConversion: false
        )
    }

    // MARK: - Private methods

    private func modifyRequest(urlRequest: inout URLRequest) {
        urlRequest.allHTTPHeaderFields?["Content-Type"] = "application/x-www-form-urlencoded; charset=utf-8"
    }
}
