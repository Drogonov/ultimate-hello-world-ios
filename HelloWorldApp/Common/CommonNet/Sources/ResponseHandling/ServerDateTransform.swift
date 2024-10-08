//
//  ServerDateTransform.swift
//  CommonNet
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import ObjectMapper

// Result is 'Mon, 05 11 2019 11:24:39 +0000'
public final class ServerDateTransform: DateFormatterTransform {
    
    // MARK: Construction
    
    public static let shared = ServerDateTransform()
    
    private init() {
        super.init(dateFormatter: ServerDateTransform.dateFormatter)
    }
    
    // MARK: Methods
    
    public override func transformFromJSON(_ value: Any?) -> Date? {
        var result: Date?
        
        if let value = value as? Date {
            result = value
        } else if let stringValue = (value as? String) {
            result = super.transformFromJSON(stringValue)
        }
        
        // Done
        return result
    }
    
    // MARK: Private Properties
    
    private static var dateFormatter: DateFormatter {
        struct Singleton {
            static let formatter: DateFormatter = {
                let object = DateFormatter()
                
                // Init instance
                object.dateFormat = Inner.DateFormat
                object.formatterBehavior = .behavior10_4
                object.locale = Locale(identifier: Inner.LocaleIdentifier)
                object.timeZone = TimeZone(secondsFromGMT: 0)
                
                // Done
                return object
            }()
        }
        
        // Done
        return Singleton.formatter
    }
    
    // MARK: Constants
    
    private struct Inner {
        static let DateFormat = "EEE, dd MM yyyy HH:mm:ss ZZZ"
        static let LocaleIdentifier = "en_En"
    }
}
