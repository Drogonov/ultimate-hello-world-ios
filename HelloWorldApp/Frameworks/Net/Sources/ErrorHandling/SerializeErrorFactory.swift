//
//  SerializeErrorFactory.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import ObjectMapper
import CommonNet

class SerializeErrorFactory {

    class func checkTransportLayerError(statusCode: Int?, url: URL?) throws {
        guard let statusCode else {
            return
        }

        switch statusCode {
        case
            NSURLErrorNetworkConnectionLost,
            NSURLErrorNotConnectedToInternet:

            throw ApiError.transportLayerError(.connection)

        case
            NSURLErrorCannotFindHost,
            NSURLErrorTimedOut,
            NSURLErrorCannotConnectToHost,
            NSURLErrorUserCancelledAuthentication:

            throw ApiError.transportLayerError(.notAvailableServer(statusCode, url))

        default:
            break
        }
    }

    class func checkSerializeResponseBodyError(
        responseInfo: ResponseInfo?,
        error: Error?,
        data: Data,
        statusCode: Int?,
        arguments: Set<SerializerType>
    ) throws {

        guard
            let statusCode = statusCode,
            let httpCode = HttpCode(rawValue: statusCode)
        else {
            throw ApiError.applicationLayerError(
                .unknownError(statusCode: statusCode, error: error),
                responseInfo: responseInfo
            )
        }

        let json = try? JSONSerialization.jsonObject(with: data)
        let errorResponse: AbstractPollingResponseMo? = Mapper<AbstractPollingResponseMo>().map(JSONObject: json)

        if !httpCode.isAcceptable() {
            throw ApiError.applicationLayerError(
                .response(statusCode: httpCode, error: errorResponse?.errorResponse),
                responseInfo: responseInfo
            )
        }

        guard let errorResponse = errorResponse else {
            return
        }

        if let _ = errorResponse.timeout, arguments.contains(.pooling) {
            throw ApiError.applicationLayerError(
                .timeout(error: errorResponse),
                responseInfo: responseInfo
            )
        } else if let errorResponseMo = errorResponse.errorResponse {
            throw ApiError.topLayerError(.business(error: errorResponseMo))
        }
    }
}

