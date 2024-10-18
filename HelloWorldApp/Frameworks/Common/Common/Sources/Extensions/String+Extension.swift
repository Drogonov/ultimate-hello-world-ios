//
//  String+Extension.swift
//  Common
//
//  Created by Anton Vlezko on 12/03/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import UIKit

public extension String {
    
    // MARK: Type Properties
    
    static let empty = ""
    static let emptyString: String = ""
    static let newLine = "\n"
    static let nonBreakingSpace = "\u{00a0}"
    static let whitespace = " "
    static let dash = "-"
    static let dot = "."
    static let comma = ","
    static let slash = "/"
    static let phoneNumberPrefix = "+7"
    static let colon = ":"
}

public extension String {
    var stringToNumber: Int? {
        return Int(self)
    }
}

public extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

public extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
}

public extension String {

    // MARK: Methods
    
    /// Trims whitespaces from the beginning of self.
    func trimStart() -> String {
        return stripStart()
    }
    
    /// Trims whitespaces from the end of self.
    func trimEnd() -> String {
        return stripEnd()
    }
    
    /// Trims whitespaces from both the beginning and the end of self.
    func trim() -> String {
        return strip()
    }
}

public extension String {

    // MARK: Methods
    
    /// Strips any of a set of characters from the start of a String.
    ///
    /// If the stripChars String is {@code nil}, whitespace is stripped.
    ///
    /// @param stripChars The characters to remove, {@code nil} treated as whitespace
    /// @return the stripped String
    ///
    func stripStart(stripChars: CharacterSet? = nil) -> String {
        let set = stripChars ?? CharacterSet.whitespacesAndNewlines
        var result = ""
        
        if let range = rangeOfCharacter(from: set.inverted) {
            result = String(self[range.lowerBound...])
        }
        return result
    }
    
    /// Strips any of a set of characters from the end of a String.
    ///
    /// If the stripChars String is {@code nil}, whitespace is stripped.
    ///
    /// @param stripChars The set of characters to remove, {@code nil} treated as whitespace
    /// @return the stripped String
    ///
    func stripEnd(stripChars: CharacterSet? = nil) -> String {
        let set = stripChars ?? CharacterSet.whitespacesAndNewlines
        var result = ""
        
        if let range = rangeOfCharacter(from: set.inverted, options: NSString.CompareOptions.backwards) {
            result = String(self[..<range.upperBound])
        }
        return result
    }
    
    /// Strips any of a set of characters from the start and end of a String.
    /// This is similar to {@link String#trim()} but allows the characters
    /// to be stripped to be controlled.
    ///
    /// If the stripChars String is {@code nil}, whitespace is stripped.
    ///
    /// @param stripChars The characters to remove, {@code nil} treated as whitespace
    /// @return the stripped String
    ///
    func strip(stripChars set: CharacterSet? = nil) -> String {
        return stripStart(stripChars: set).stripEnd(stripChars: set)
    }
}

public extension String {

    // MARK: Properties
    
    /// Checks if a String is not empty ("").
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
}

public extension Optional where Wrapped == String {

    // MARK: Properties
    
    /// Checks if a String is empty ("") or nil.
    var isEmpty: Bool {
        return (self == nil) || self!.isEmpty
    }
    
    /// Checks if a String is not empty ("") and not nil.
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
}

public extension String {

    // MARK: Properties

    /// Checks if a String is empty ("") or whitespace only.
    var isBlank: Bool {
        return trim().isEmpty
    }

    /// Checks if a String is not empty ("") and not whitespace only.
    var isNotBlank: Bool {
        return !self.isBlank
    }
}


public extension Optional where Wrapped == String {

    // MARK: Properties

    /// Checks if a String is empty (""), nil or whitespace only.
    var isBlank: Bool {
        return (self == nil) || self!.trim().isEmpty
    }

    /// Checks if a String is not empty (""), not nil and not whitespace only.
    var isNotBlank: Bool {
        return !self.isBlank
    }
}
