//
//  DictionarySerializer.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

extension String {
    public var URLEncode: String {
        var set = CharacterSet.alphanumerics
        set.insert(charactersIn: "_.-~")
        return addingPercentEncoding(withAllowedCharacters: set) ?? self
    }

    public var urlDecode: String {
        removingPercentEncoding ?? self
    }
}

open class DictionarySerializer {

    public static func serialize(parameters: GetParameters) -> String {
        return serialize(dict: parameters.params, transforms: parameters.transforms)
    }

    public static func serialize(dict: [String: Any], transforms: [String: ArrayTransformType] = [:]) -> String {
        var strings: [String] = []

        let sorted = dict.sorted(by: { $0.key > $1.key })
        for (key, value) in sorted {
            let string = serialize(value: value, with: key, transforms: transforms)
            strings.append(string)
        }

        return strings.joined(separator: "&")
    }

    public static func serialize(array: [Any], with key: String? = nil, transforms: [String: ArrayTransformType]) -> String {
        var result = ""

        if let key = key {
            let transformType = transforms[key] ?? .enumerated
            result = applyTransform(transformType, array: array, with: key)
        }

        return result
    }

    public static func serialize(value: Any, with key: String?, transforms: [String: ArrayTransformType] = [:]) -> String {
        var result = ""

        if let value = value as? String {
            let encodedValue = value.URLEncode
            result = serializeOptionalKeyValue(key: key, value: encodedValue)
        } else if type(of: value) == Bool.self {
            result = serializeOptionalKeyValue(key: key, value: "\(value)")
        } else if let value = value as? NSNumber {
            let encodedValue = value.stringValue.URLEncode
            result = serializeOptionalKeyValue(key: key, value: encodedValue)
        } else if let value = value as? [String: Any] {
            result = serialize(dict: value)
        } else if let value = value as? [Any] {
            result = serialize(array: value, with: key, transforms: transforms)
        }

        return result
    }

    public static func serializeFor(
        _ dict: [String: Any],
        transform: [String: ArrayTransformType]? = nil,
        urlEncoding: Bool = false
    ) -> String {
        var components: [(String, String)] = []

        for (key, value) in dict.sorted(by: { $0.key > $1.key }) {
            components += queryComponents(fromKey: key, value: value, trasforms: transform)
        }

        let result = components.map {
            if $0.isEmpty {
                return urlEncoding ? "\($1)" : "\($1.urlDecode)"
            } else {
                return urlEncoding ? "\($0)=\($1)" : "\($0)=\($1.urlDecode)"
            }
        }
        .joined(separator: Constants.ampersand)

        return result
    }

    public static func flatKeyValue(dict: [String: Any]) -> [String: String] {
        let string = serialize(dict: dict)
        let components = string.components(separatedBy: "&")
        var keyValues: [String: String] = [:]
        for item in components {
            let components = item.components(separatedBy: "=")
            if components.count != 2 { continue }
            keyValues[components[0]] = components[1]
        }
        return keyValues
    }

    private static func applyTransform(_ type: ArrayTransformType, array: [Any], with key: String? = nil) -> String {
        var result: String?

        switch type {
        case .commaSeparated:
            result = GetParamsArrayCommaSeparatedTransform().toString(array, key: key)

        case .enumerated:
            result = EnumeratedArrayTransform().toString(array, key: key)

        case .keyRepetative:
            result = ArrayKeyRepetativeTransform().toString(array, key: key)
        }

        return result ?? String()
    }

    private static func serializeOptionalKeyValue(key: String?, value: String) -> String {
        var result = ""
        if let key = key {
            result = "\(key)=\(value)"
        } else {
            result = value
        }

        return result
    }
}

// MARK: - Private methods

private extension DictionarySerializer {

    static func encodeBool(value: Bool) -> String {
        value ? Constants.oneString : Constants.zeroString
    }

    static func escape(_ string: String) -> String {
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: Constants.delimitersToEncode)

        let escaped = string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string

        return escaped
    }

    static func queryComponents(
        fromKey key: String,
        value: Any,
        trasforms: [String: ArrayTransformType]?
    ) -> [(String, String)] {
        var components: [(String, String)] = []

        if let dictionary = value as? [String: Any] {
            for (nestedKey, value) in dictionary {
                components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value, trasforms: trasforms)
            }
        } else if let array = value as? [Any] {
            var result: String = Constants.emptyString
            var localComponets: [(String, String)] = []

            switch trasforms?[key] ?? .enumerated {
            case .enumerated:
                for (index, element) in array.enumerated() {
                    localComponets += queryComponents(fromKey: "\(key)[\(index)]", value: element, trasforms: trasforms)
                }
                result = localComponets.map { "\($0)=\($1)" }.joined(separator: Constants.ampersand)

            case .commaSeparated:
                result = "\(key)="
                for localValue in array {
                    localComponets += queryComponents(fromKey: Constants.emptyString, value: localValue, trasforms: trasforms)
                }
                result += localComponets.map { "\($1)" }.joined(separator: Constants.comma)

            case .keyRepetative:
                for array in array {
                    localComponets += queryComponents(fromKey: "\(key)", value: array, trasforms: trasforms)
                }
                result = localComponets.map { "\($0)=\($1)" }.joined(separator: Constants.ampersand)
            }
            components += [(Constants.emptyString, result)]
        } else if let value = value as? NSNumber {
            if value.isBool {
                components.append((escape(key), encodeBool(value: value.boolValue)))
            } else {
                components.append((escape(key), escape("\(value)")))
            }
        } else if let bool = value as? Bool {
            components.append((escape(key), encodeBool(value: bool)))
        } else {
            components.append((escape(key), escape("\(value)")))
        }

        return components
    }
}

// MARK: - Constants

fileprivate extension DictionarySerializer {

    enum Constants {
        static let delimitersToEncode = ":#[]@!$&'()*+,;="
        static let ampersand = "&"
        static let comma = ","
        static let zeroString = "0"
        static let oneString = "1"
        static let emptyString = ""
    }
}

