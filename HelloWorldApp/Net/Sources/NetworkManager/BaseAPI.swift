//
//  BaseAPI.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

// MARK: BaseApiMap

public protocol BaseAPI {
    var networkClient: NetworkManagerProtocol { get }
    var errorHandler: NetErrorHandler { get }
}

public extension BaseAPI {
    func performRequest<Request: NetRequestResponseProtocol>(request: Request) async throws -> Request.ParsedModel {
        do {
            return try await networkClient.makeRequest(request: request)
        } catch {
            try errorHandler.handle(error: error)
            throw error
        }
    }
}
