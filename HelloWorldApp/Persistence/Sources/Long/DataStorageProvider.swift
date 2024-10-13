//
//  DataStorageProvider.swift
//  Persistence
//
//  Created by Anton Vlezko on 11/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation

public protocol DataStorageProvider {
    /**
     Setup configuration for database
     */
    func setup()
    /**
     Read url response from cache
     - parameter url: Url identifier
     - parameter completion: Closure returns data when read have done successfully
     */
    func read(url: String) -> [String: Any]?
    /**
     Write url response to cache
     - parameter url: Url identifier
     - parameter data: Data to cache
     */
    func write(url: String, data: [String: Any], group: String?)
    /**
     Clear cache
     */
    func clear()
    /**
     Remove object for Url
     - parameter url: Url identifier (if url without query paramters will be removed all objects with url path)
    */
    func remove(url: String)

    func remove(group: String)

    func hasValidCache(url: String, group: String?) -> Bool
}

