//
//  NSNumber+Extension.swift
//  Common
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

public extension NSNumber {

    // MARK: Properties

    var isBool: Bool {
        CFBooleanGetTypeID() == CFGetTypeID(self)
    }
}
