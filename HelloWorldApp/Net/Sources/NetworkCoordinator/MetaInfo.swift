//
//  MetaInfo.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Persistence

public struct MetaInfo {

    public init(
        cacheKey: CacheKeyable? = nil,
        forceRequest: Bool = false
    ) {
        self.cacheKey = cacheKey
        self.forceRequest = forceRequest
    }

    public let cacheKey: CacheKeyable?
    public let forceRequest: Bool
}
