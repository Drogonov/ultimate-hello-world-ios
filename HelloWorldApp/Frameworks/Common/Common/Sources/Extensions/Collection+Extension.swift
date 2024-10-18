//
//  Collection+Extension.swift
//  Common
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

public extension Collection {

    // MARK: Properties

    /// Checks if collection has elements.
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
}

public extension Optional where Wrapped: Collection {
    
    // MARK: Properties

    /// Checks if collection has no elements or nil.
    var isEmpty: Bool {
        return (self == nil) || self!.isEmpty
    }

    /// Checks if collection has elements and not nil.
    var isNotEmpty: Bool {
        return !isEmpty
    }
}
