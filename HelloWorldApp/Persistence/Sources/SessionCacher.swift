//
//  SessionCacher.swift
//  Persistence
//
//  Created by Anton Vlezko on 29/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

// MARK: - SessionCacher

public class SessionCacher {
    var dictionary: [String: Any?] = [:]

    public init() {}
}

// MARK: - CNCacheProtocol

extension SessionCacher: CacheProtocol {

    public func read<T>(_ type: T.Type, withKey key: CacheKeyable) -> T? {
        dictionary[key.value] as? T
    }

    public func read<T>(key: CacheKeyable) -> T? {
        dictionary[key.value] as? T
    }

    public func write<T>(_ data: T, withKey key: CacheKeyable) {
        dictionary[key.value] = data
    }

    public func remove(key: CacheKeyable) {
        dictionary[key.value] = nil
    }

    public func clean() {
        dictionary.removeAll()
    }
}

