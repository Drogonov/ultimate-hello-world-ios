//
//  LongCacher.swift
//  Persistence
//
//  Created by Anton Vlezko on 11/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import CommonNet
import DI
import Foundation

// MARK: - LongCacher

public class LongCacher {

    @DelayedImmutable public var realmService: RealmServiceProtocol

    public init() {}
}

// MARK: - CNCacheProtocol

extension LongCacher: CacheProtocol {

    public func read<T>(_ type: T.Type, withKey key: CacheKeyable) -> T? {
        read(key: key)
    }

    public func read<T>(key: CacheKeyable) -> T? {
        guard T.self is DataCodable.Type || T.self is Codable.Type else {
            fatalError("You need to create you own logic to proceed not DataCodable types")
        }

        let record: LongCachedRecord? = realmService.read(cacheKey: key.value)
        guard let data = record?.data,
              let dataUtf8 = data.data(using: .utf8) else {
            return nil
        }

        var result: DataCodable?

        result = (T.self as? DataCodable.Type)?.decode(dataUtf8)

        return result as? T
    }

    public func write<T>(_ data: T, withKey key: CacheKeyable) {
        guard let encodedString = (data as? DataCodable)?.encode() else {
            return
        }
        let record = LongCachedRecord(key: key.value, data: encodedString)
        realmService.write(cacheKey: key.value, data: record)
    }

    public func remove(key: CacheKeyable) {
        realmService.remove(type: LongCachedRecord.self, cacheKey: key.value)
    }

    public func clean() {
        realmService.clear(type: LongCachedRecord.self)
    }
}
