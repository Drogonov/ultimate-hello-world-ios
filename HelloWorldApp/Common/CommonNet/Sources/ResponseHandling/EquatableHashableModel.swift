//
//  EquatableHashableModel.swift
//  CommonNet
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

open class EquatableHashableModel: Equatable {

    // MARK: Init
    
    public init() {}
    
    // MARK: Methods

    /// http://stackoverflow.com/a/24240011
    /// Must override this method to define custom equality behaviour by each property
    open func isEqual(to other: EquatableHashableModel) -> Bool {
        return false
    }
    
    // MARK: @protocol Equatable
    
    public static func == (lhs: EquatableHashableModel, rhs: EquatableHashableModel) -> Bool {
        if lhs === rhs {
            return true
        } else if type(of: lhs) !== type(of: rhs) {
            return false
        } else {
            return lhs.isEqual(to: rhs)
        }
    }
}
