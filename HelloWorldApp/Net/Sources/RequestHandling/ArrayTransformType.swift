//
//  ArrayTransformType.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

/// Network request array parameter serealization type
///
/// - enumerated: Default.
/// ````
/// Example: "key[0]=value0&key[1]=value1&key[2]=value2"
/// ````
/// - commaSeparated
/// ````
/// Example: "key=value0,value1,value2"
/// ````
/// - keyRepetative
/// ````
/// Example: "key=value0&key=value1&key=value2"
/// ````
public enum ArrayTransformType {
    case enumerated
    case commaSeparated
    case keyRepetative
}
