//
//  CommonCacheKey.swift
//  Persistence
//
//  Created by Anton Vlezko on 29/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

public enum CommonCacheKey: String, CacheKeyable {
    case isShownAlert = "isShownAlert"
    case isUserLoggedIn = "isUserLoggedIn"
    case isUserSawOnboarding = "isUserSawOnboarding"

    public var value: String {
        rawValue
    }
}
