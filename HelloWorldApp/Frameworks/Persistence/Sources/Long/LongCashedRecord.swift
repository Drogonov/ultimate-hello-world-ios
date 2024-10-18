//
//  LongCashedRecord.swift
//  Persistence
//
//  Created by Anton Vlezko on 11/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import RealmSwift

public class LongCachedRecord: Object {
    @objc dynamic var key: String = String.empty {
        didSet {
            compoundKey = key
        }
    }

    @objc dynamic var data: String?
    @objc dynamic var expiredDate: Date?
    @objc dynamic var compoundKey: String = String.empty

    init(key: String, data: String?, expiredDate: Date? = nil) {
        self.key = key
        self.compoundKey = key
        self.data = data
        self.expiredDate = expiredDate
    }

    required override init() {
        self.data = nil
        self.expiredDate = nil
    }

    public override static func primaryKey() -> String? {
        return "compoundKey"
    }
}

