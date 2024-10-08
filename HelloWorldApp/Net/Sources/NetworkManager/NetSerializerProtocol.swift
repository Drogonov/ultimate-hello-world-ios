//
//  NetSerializerProtocol.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

public protocol NetSerializerProtocol {

    associatedtype ParsedModel

    func serialize<RequestResponse: NetRequestResponseProtocol>(
        requestData: Data?,
        response: URLResponse?,
        error: Error?,
        request: RequestResponse?
    ) throws -> ParsedModel
}
