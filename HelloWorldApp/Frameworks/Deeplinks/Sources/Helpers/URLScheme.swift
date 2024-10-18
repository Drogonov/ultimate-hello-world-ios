//
//  URLScheme.swift
//  Deeplinks
//
//  Created by Anton Vlezko on 27/09/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

public enum URLScheme: String {
    case http = "http://"
    case https = "https://"

    public func lenght() -> Int {
        rawValue.count
    }
}
