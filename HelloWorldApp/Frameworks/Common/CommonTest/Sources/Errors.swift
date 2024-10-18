//
//  Errors.swift
//  CommonTest
//
//  Created by Anton Vlezko on 16/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation

open class ConversionError: Error {

    // MARK: Properties

    /// A human-readable message string summarizing the reason for the error.
    public let reason: String?

    /// A dictionary containing JSON data.
    public let JSON: [String: Any]?

    public let cause: Error?

    // MARK: Construction

    /// Initializes and returns a newly created error object.
    ///
    /// - Parameters:
    ///   - reason: A human-readable message string summarizing the reason for the exception.
    ///   - JSON: A dictionary containing JSON data.
    ///   - cause: The error that is the cause of the current error, or a `nil` reference if no cause is specified.
    ///
    public init(
        reason: String? = nil,
        JSON: [String: Any]? = nil,
        cause: Error? = nil
    ) {
        self.reason = reason
        self.JSON = JSON
        self.cause = cause
    }
}

public enum JsonLoaderError: LocalizedError {
    case emptyName
    case notLoad(String)
    case notParse(String, ConversionError?)
    case emptyFile

    public var description: String {
        switch self {
        case .emptyName:
            return "‘filename’ is empty"
        case .notLoad(let filename):
            return "Could not load file: \(filename).json"
        case let .notParse(filename, error):
            var string = "Could not parse JSON from file: \(filename).json"
            if let error = error?.reason {
                string = "\(string). Error: \(error)"
            }
            return string
        case .emptyFile:
            return "loaded JSON is nil"
        }
    }
}
