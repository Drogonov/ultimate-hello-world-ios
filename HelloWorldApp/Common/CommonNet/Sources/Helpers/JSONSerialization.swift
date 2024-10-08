//
//  JSONSerialization.swift
//  CommonNet
//
//  Created by Anton Vlezko on 30/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

/// https://stackoverflow.com/q/35053577/1033581
extension JSONSerialization {

    public class func dataExt(withJSONObject obj: Any, options opt: JSONSerialization.WritingOptions = []) throws -> Data {
        return try data(withJSONObject: jsonObjectExt(obj), options: opt)
    }

    fileprivate static func jsonObjectExt(_ anObject: Any) -> Any {
        let value: Any
        if let n = anObject as? [String: Any] {
            // subclassing children
            var dic = [String: Any]()
            n.forEach { dic[$0] = jsonObjectExt($1) }
            value = dic
        } else if let n = anObject as? [Any] {
            // subclassing children
            var arr = [Any]()
            n.forEach { arr.append(jsonObjectExt($0)) }
            value = arr
        } else if let n = anObject as? NSNumber, CFNumberGetType(n) == .float64Type {
            let d = Double(truncating: n)
            value = NSDecimalNumber(string: d.description)
        } else {
            value = anObject
        }
        return value
    }
}
