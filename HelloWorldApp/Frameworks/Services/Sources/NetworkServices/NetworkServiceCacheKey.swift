//
//  NetworkServiceCacheKey.swift
//  Services
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Persistence

enum NetworkServiceCacheKey: String, CacheKeyable {
    case getHello
    case getCountries
    case getInfo
    case getMagic
    case singUp
    case singIn
    case logout
    case verifyOTP
    case resendOTP

    public var value: String {
        self.rawValue
    }
}
