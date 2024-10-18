//
//  RealmService.swift
//  Persistence
//
//  Created by Anton Vlezko on 11/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import DI
import Foundation
import RealmSwift

// MARK: - Protocol

public protocol RealmServiceProtocol {
    func read<T: Object>(cacheKey: String) -> T?
    func write<T: Object>(cacheKey: String, data: T)
    func clear<T: Object>(type: T.Type)
    func remove<T: Object>(type: T.Type, cacheKey: String)
}

// MARK: - RealmService

public class RealmService {

    private let schemaVersionNumber: UInt64 = 1

    private lazy var config: Realm.Configuration = {

        let configuration = Realm.Configuration(
            schemaVersion: schemaVersionNumber,
            deleteRealmIfMigrationNeeded: true
        )
        return configuration
     }()

    // MARK: Init

    public init() {}
}

// MARK: - RealmServiceProtocol

extension RealmService: RealmServiceProtocol {

    public func read<T: Object>(cacheKey: String) -> T? {
        do {
            removeExpired(type: T.self)
            let realm = try Realm(configuration: config)
            let cachedRecord = realm.objects(T.self).filter("key == %@", cacheKey, Date()).first
            return cachedRecord
        } catch {
            return nil
        }
    }

    public func write<T: Object>(cacheKey: String, data: T) {
        do {
            removeExpired(type: T.self)
            let realm = try Realm(configuration: config)
            try realm.write {
                let oldResponse = realm.objects(T.self).filter("key == %@", cacheKey).first
                let updatePolicy: Realm.UpdatePolicy = oldResponse != nil ? .all : .error
                realm.add(data, update: updatePolicy)
            }
        } catch {
            CustomLogger.message.log("\(RealmService.self) \(error.localizedDescription)")
        }
    }

    public func clear<T: Object>(type: T.Type) {
        do {
            let realm = try Realm(configuration: config)
            try realm.write {
                let objs = realm.objects(type.self)
                if !objs.isEmpty {
                    realm.delete(objs)
                }
            }
        } catch {
            CustomLogger.message.log("\(RealmService.self) \(error.localizedDescription)")
        }
    }

    public func remove<T: Object>(type: T.Type, cacheKey: String) {
        do {
            let realm = try Realm(configuration: config)
            try realm.write {
                let filterPredicate = NSPredicate(format: "key == %@", cacheKey)
                let objs = realm.objects(type.self).filter(filterPredicate)
                if !objs.isEmpty {
                    realm.delete(objs)
                }
            }
        } catch {
            CustomLogger.message.log("\(RealmService.self) \(error.localizedDescription)")
        }
    }
}

// MARK: - Private

fileprivate extension RealmService {

    func removeExpired<T: Object>(type: T.Type) {
        do {
            let realm = try Realm(configuration: config)

            try realm.write {
                let expiredResponses = realm.objects(type.self).filter("expiredDate < %@", Date())
                realm.delete(expiredResponses)
            }
        } catch {
            CustomLogger.message.log("\(RealmService.self) \(error.localizedDescription)")
        }
    }
}

