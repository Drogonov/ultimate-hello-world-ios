//
//  ArrayKeyRepetativeTransform.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

public class ArrayKeyRepetativeTransform: ArrayTransformProtocol {

    public func toString(_ value: [Any], key: String?) -> String? {
        var serializedStrings = [String]()

        for element in value {
            if let key = key {
                let serializedString = DictionarySerializer.serialize(value: element, with: key)

                if !serializedString.isEmpty {
                    serializedStrings.append(serializedString)
                }
            }
        }

        return serializedStrings.joined(separator: "&")
    }
}
