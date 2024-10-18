//
//  InfoURLsKey.swift
//  Deeplinks
//
//  Created by Anton Vlezko on 01/10/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Persistence

public enum InfoURLsKey: String {
    case pushLinkRoot = "PUSH_LINK_ROOT"
}

extension InfoURLsKey: CacheKeyable {
    public var value: String {
        rawValue
    }
}
