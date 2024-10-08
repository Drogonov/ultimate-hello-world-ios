//
//  UniversalMappableSerializer.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import ObjectMapper
import Resources
import CommonNet

// MARK: - UniversalSerializer class

// Use this class to get old RCMBase single objects from server responses
public class UniversalMappableSerializer<ParsedModel: BaseResponse>: NetSerializerProtocol {

    // MARK: Init

    public init(_ arguments: Set<SerializerType> = []) {
        self.arguments = arguments
    }

    // MARK: Private properties

    private let arguments: Set<SerializerType>

    // MARK:  Public methods

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

        try SerializeErrorFactory.checkSerializeResponseBodyError(responseInfo: responseInfo, error: error, data: data, statusCode: statusCode, arguments: arguments)

        var json: Any?
        do {
            json = try JSONSerialization.jsonObject(with: data)
        } catch {
            var reason = ResourcesStrings.errorSerialization()
            if let mapError = error as? MapError {
                reason = mapError.description
            }
            throw ApiError.applicationLayerError(
                .conversion(reason: reason, data: requestData, error: error),
                responseInfo: responseInfo
            )
        }

        guard let json = json else {
            let reason = ResourcesStrings.errorConvertation(response?.url?.absoluteString ?? String.empty)
            throw ApiError.applicationLayerError(
                .conversion(reason: reason, data: requestData, error: error),
                responseInfo: responseInfo
            )
        }

        var mapped: ParsedModel?
        do {
            mapped = try Mapper<ParsedModel>().map(JSONObject: json) as ParsedModel
        } catch {
            var reason: String = ResourcesStrings.errorSerialization()
            if let error = error as? MapError {
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
