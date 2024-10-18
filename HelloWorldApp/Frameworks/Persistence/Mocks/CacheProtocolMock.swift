//
//  CacheProtocolMock.swift
//  PersistenceMocks
//
//  Created by Anton Vlezko on 06/10/2024.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation
@testable import Persistence

public  class CacheProtocolMock: CacheProtocol {

    public init() {}

    //MARK: - read<T>

    public var readTKeyCacheKeyableTCallsCount = 0
    public var readTKeyCacheKeyableTCalled: Bool {
        return readTKeyCacheKeyableTCallsCount > 0
    }
    public var readTKeyCacheKeyableTReceivedKey: (CacheKeyable)?
    public var readTKeyCacheKeyableTReceivedInvocations: [(CacheKeyable)] = []
    public var readTKeyCacheKeyableTReturnValue: Any?
    public var readTKeyCacheKeyableTClosure: ((CacheKeyable) -> Any?)?

    public func read<T>(key: CacheKeyable) -> T? {
        readTKeyCacheKeyableTCallsCount += 1
        readTKeyCacheKeyableTReceivedKey = key
        readTKeyCacheKeyableTReceivedInvocations.append(key)
        if let readTKeyCacheKeyableTClosure = readTKeyCacheKeyableTClosure {
            return readTKeyCacheKeyableTClosure(key) as? T
        } else {
            return readTKeyCacheKeyableTReturnValue as? T
        }
    }

    //MARK: - read<T>

    public var readTTypeTTypeWithKeyKeyCacheKeyableTCallsCount = 0
    public var readTTypeTTypeWithKeyKeyCacheKeyableTCalled: Bool {
        return readTTypeTTypeWithKeyKeyCacheKeyableTCallsCount > 0
    }
    public var readTTypeTTypeWithKeyKeyCacheKeyableTReceivedArguments: (type: Any.Type, key: CacheKeyable)?
    public var readTTypeTTypeWithKeyKeyCacheKeyableTReceivedInvocations: [(type: Any.Type, key: CacheKeyable)] = []
    public var readTTypeTTypeWithKeyKeyCacheKeyableTReturnValue: Any?
    public var readTTypeTTypeWithKeyKeyCacheKeyableTClosure: ((Any.Type, CacheKeyable) -> Any?)?

    public func read<T>(_ type: T.Type, withKey key: CacheKeyable) -> T? {
        readTTypeTTypeWithKeyKeyCacheKeyableTCallsCount += 1
        readTTypeTTypeWithKeyKeyCacheKeyableTReceivedArguments = (type: type, key: key)
        readTTypeTTypeWithKeyKeyCacheKeyableTReceivedInvocations.append((type: type, key: key))
        if let readTTypeTTypeWithKeyKeyCacheKeyableTClosure = readTTypeTTypeWithKeyKeyCacheKeyableTClosure {
            return readTTypeTTypeWithKeyKeyCacheKeyableTClosure(type, key) as? T
        } else {
            return readTTypeTTypeWithKeyKeyCacheKeyableTReturnValue as? T
        }
    }

    //MARK: - write<T>

    public var writeTDataTWithKeyCacheKeyableVoidCallsCount = 0
    public var writeTDataTWithKeyCacheKeyableVoidCalled: Bool {
        return writeTDataTWithKeyCacheKeyableVoidCallsCount > 0
    }
    public var writeTDataTWithKeyCacheKeyableVoidReceivedArguments: (data: Any, withKey: CacheKeyable)?
    public var writeTDataTWithKeyCacheKeyableVoidReceivedInvocations: [(data: Any, withKey: CacheKeyable)] = []
    public var writeTDataTWithKeyCacheKeyableVoidClosure: ((Any, CacheKeyable) -> Void)?

    public func write<T>(_ data: T, withKey: CacheKeyable) {
        writeTDataTWithKeyCacheKeyableVoidCallsCount += 1
        writeTDataTWithKeyCacheKeyableVoidReceivedArguments = (data: data, withKey: withKey)
        writeTDataTWithKeyCacheKeyableVoidReceivedInvocations.append((data: data, withKey: withKey))
        writeTDataTWithKeyCacheKeyableVoidClosure?(data, withKey)
    }

    //MARK: - remove

    public var removeKeyCacheKeyableVoidCallsCount = 0
    public var removeKeyCacheKeyableVoidCalled: Bool {
        return removeKeyCacheKeyableVoidCallsCount > 0
    }
    public var removeKeyCacheKeyableVoidReceivedKey: (CacheKeyable)?
    public var removeKeyCacheKeyableVoidReceivedInvocations: [(CacheKeyable)] = []
    public var removeKeyCacheKeyableVoidClosure: ((CacheKeyable) -> Void)?

    public func remove(key: CacheKeyable) {
        removeKeyCacheKeyableVoidCallsCount += 1
        removeKeyCacheKeyableVoidReceivedKey = key
        removeKeyCacheKeyableVoidReceivedInvocations.append(key)
        removeKeyCacheKeyableVoidClosure?(key)
    }

    //MARK: - clean

    public var cleanVoidCallsCount = 0
    public var cleanVoidCalled: Bool {
        return cleanVoidCallsCount > 0
    }
    public var cleanVoidClosure: (() -> Void)?

    public func clean() {
        cleanVoidCallsCount += 1
        cleanVoidClosure?()
    }


}
