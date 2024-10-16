//
//  Dictionary+Extension.swift
//  Common
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import UIKit

public extension Dictionary {
    static func + (lhs: Self, rhs: Self) -> Self {
        var leftCopy = lhs
        rhs.forEach { (key, value) in
            leftCopy[key] = value
        }

        return leftCopy
    }

    static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }
}

public extension Dictionary {
    mutating func setValue(value: Any, forKeyPath keyPath: String) {
        var keys = keyPath.components(separatedBy: ".")
        guard let first = keys.first as? Key else {
            debugPrint("Unable to use string as key on type: \(Key.self)")
            return
        }
        keys.remove(at: 0)
        if keys.isEmpty, let settable = value as? Value {
            self[first] = settable
        } else {
            let rejoined = keys.joined(separator: ".")
            var subdict: [NSObject: AnyObject] = [:]
            if let sub = self[first] as? [NSObject: AnyObject] {
                subdict = sub
            }
            subdict.setValue(value: value, forKeyPath: rejoined)
            if let settable = subdict as? Value {
                self[first] = settable
            } else {
                debugPrint("Unable to set value: \(subdict) to dictionary of type: \(type(of: self))")
            }
        }
    }

    func value<T>(for keyPath: String) -> T? {
        var keys = keyPath.components(separatedBy: ".")
        guard let first = keys.first as? Key else {
            debugPrint("Unable to use string as key on type: \(Key.self)")
            return nil
        }
        guard let value = self[first] else {
            return nil
        }
        keys.remove(at: 0)
        if !keys.isEmpty, let subDict = value as? [NSObject: AnyObject] {
            let rejoined = keys.joined(separator: ".")

            return subDict.value(for: rejoined)
        }
        return value as? T
    }

    func toJsonString() -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8)
        } catch {
            return nil
        }
    }
}
