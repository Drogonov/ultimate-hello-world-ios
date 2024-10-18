//
//  GetParamsArrayCommaSeparatedTransform.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import ObjectMapper

public class GetParamsArrayCommaSeparatedTransform: ArrayTransformProtocol {
// MARK: - Methods

    func toString(_ value: [Any], key: String?) -> String? {
        var result: String?

        var serializedStrings = [String]()

        if let key = key {
            result = "\(key)="

            for element in value {
                let serializedString = DictionarySerializer.serialize(value: element, with: nil)
                if !serializedString.isEmpty {
                    serializedStrings.append(serializedString)
                }
            }

            result?.append(serializedStrings.joined(separator: ","))
        }

        return result
    }
}
