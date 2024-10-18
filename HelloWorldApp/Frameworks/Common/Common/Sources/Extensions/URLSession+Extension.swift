//
//  URLSession+Extension.swift
//  Common
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

// MARK: iOS 13 support
public extension URLSession {

    enum IosWrapperError: Error {
        case noResponse(String, Int)
    }

    @available(iOS 13, macOS 12, *)
    func performDataTask(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }

                guard let data = data, let response = response
                else {
                    continuation.resume(throwing: IosWrapperError.noResponse(#file, #line))
                    return
                }

                continuation.resume(returning: (data, response))
            }
            .resume()
        }
    }
}
