//
//  CNCacheProtocol.swift
//  Persistence
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

public protocol CacheKeyable {
    var value: String { get }
}

// sourcery: AutoMockable
public protocol CacheProtocol {
    ///  func read<T>(key: CacheKeyable) -> T?
    ///  or
    ///  func read<T>(_ type:T.Type, withKey key: CacheKeyable) -> T?
    func read<T>(key: CacheKeyable) -> T?

    func read<T>(_ type: T.Type, withKey key: CacheKeyable) -> T?

    func write<T>(_ data: T, withKey: CacheKeyable)

    func remove(key: CacheKeyable)

    func clean()
}
