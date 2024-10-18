//
//  NetworkCoordinator.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Persistence

public struct NetworkCoordinator {

    // MARK: Public Methods

    public static func proceed<T>(
        repeater: RepeaterProtocol? = nil,
        cacher: CacheProtocol? = nil,
        metaInfo: MetaInfo = MetaInfo(),
        requestBlock: () async throws -> T
    ) async throws -> T {
        var result: T

        if let key = metaInfo.cacheKey,
           !metaInfo.forceRequest,
           let result: T = cacher?.read(key: key) {
            return result
        }

        result = try await waitRequestResult(repeater: repeater, requestBlock: requestBlock)

        if let cacher = cacher,
           let key = metaInfo.cacheKey {
            cacher.write(result, withKey: key)
        }

        return result
    }

    public static func proceed<T>(
        repeater: RepeaterProtocol? = nil,
        metaInfo: MetaInfo = MetaInfo(),
        firstRequestBlock: () async throws -> T,
        repeatingRequestBlock: () async throws -> T
    ) async throws -> T {
        try await waitRequestResult(
            repeater: repeater,
            firstRequestBlock: firstRequestBlock,
            repeatingRequestBlock: repeatingRequestBlock
        )
    }

    // MARK: Private Methods

    private static func waitRequestResult<T>(
        repeater: RepeaterProtocol?,
        requestBlock: () async throws -> T
    ) async throws -> T {

        var result: T?

        while result == nil {
            do {
                return try await requestBlock()
            } catch {
                guard let repeater = repeater else {
                    throw error
                }

                if try await repeater.checkForRepeatAndWaitIfNeeded(error: error) {
                    continue
                } else {
                    throw error
                }
            }
        }
        /// out for the apocalypse
        result = nil
        return result!
    }

    private static func waitRequestResult<T>(
        repeater: RepeaterProtocol?,
        firstRequestBlock: () async throws -> T,
        repeatingRequestBlock: () async throws -> T
    ) async throws -> T {
        var result: T?
        var requestBlock = firstRequestBlock

        while result == nil {
            do {
                return try await requestBlock()
            } catch {
                guard let repeater = repeater else {
                    throw error
                }

                if try await repeater.checkForRepeatAndWaitIfNeeded(error: error) {
                    requestBlock = repeatingRequestBlock
                    continue
                } else {
                    throw error
                }
            }
        }

        /// out for the apocalypse
        result = nil
        return result!
    }
}
