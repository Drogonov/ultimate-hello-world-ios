//
//  UniversalCodableSerializer.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import ObjectMapper
import Resources
import CommonNet

// MARK: - UniversalCodableSerializer class

// Use this class to get any Codable type - single object or array of Codable

public class UniversalCodableSerializer<ParsedModel: Codable>: NetSerializerProtocol {

    // MARK:  Private properties

    private let arguments: Set<SerializerType>

    // MARK: Init

    public init(_ arguments: Set<SerializerType> = []) {
        self.arguments = arguments
    }

    // MARK: Public methods
    public func serialize<RequestResponse: NetRequestResponseProtocol>(
        requestData: Data?,
        response: URLResponse?,
        error: Error?,
        request: RequestResponse?
    ) throws -> ParsedModel {

        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? (error as? URLError)?.errorCode
        let responseInfo = ResponseInfo(with: response)

        try SerializeErrorFactory.checkTransportLayerError(statusCode: statusCode, url: response?.url)

        guard let data = requestData else {
            let reason = ResourcesStrings.errorEmptyData(response?.url?.absoluteString ?? String.empty)
            throw ApiError.applicationLayerError(
                .conversion(reason: reason, data: requestData, error: error),
                responseInfo: responseInfo
            )
        }

        try SerializeErrorFactory.checkSerializeResponseBodyError(
            responseInfo: responseInfo,
            error: error,
            data: data,
            statusCode: statusCode,
            arguments: arguments
        )

        var mapped: ParsedModel?
        do {
            mapped = try JSONDecoder().decode(ParsedModel.self, from: data)
        } catch {
            var reason: String = ResourcesStrings.errorSerialization()
            if let error = error as? DecodingError {
                reason = error.description
            }
            throw ApiError.applicationLayerError(
                .conversion(reason: reason, data: requestData, error: error),
                responseInfo: responseInfo
            )
        }

        if let mapped = mapped {
            return mapped
        } else {
            let reason = ResourcesStrings.errorConvertationNil(response?.url?.absoluteString ?? String.empty)
            throw ApiError.applicationLayerError(
                .conversion(reason: reason, data: requestData, error: error),
                responseInfo: responseInfo
            )
        }
    }
}
