//
//  EnumeratedArrayTransform.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

final class EnumeratedArrayTransform: ArrayTransformProtocol {

    func toString(_ value: [Any], key: String? = nil) -> String? {
        var serializedStrings = [String]()

        for (idx, value) in value.enumerated() {
            var arrayKey: String?
            if let key = key {
                arrayKey = "\(key)[\(idx)]"
            }

            let serializedString = DictionarySerializer.serialize(value: value, with: arrayKey)
            if !serializedString.isEmpty {
                serializedStrings.append(serializedString)
            }
        }

        return serializedStrings.joined(separator: "&")
    }
}
