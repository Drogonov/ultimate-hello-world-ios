//
//  Converters.swift
//  CommonTest
//
//  Created by Anton Vlezko on 16/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import CommonNet
import ObjectMapper

// MARK: - ResponseConverterProtocol

public protocol ResponseConverterProtocol {

    func convert(object: Any?) throws -> T

    associatedtype T
}

// MARK: - AbstractCallResultConverter

open class AbstractCallResultConverter<T>: ResponseConverterProtocol {

    // MARK: Construction

    public init() {}

    // MARK: Methods

    public func convert(object: Any?) throws -> T {
        fatalError("Must be overrided")
    }
}

// MARK: - AbstractValidatableModelArrayConverter

open class AbstractValidatableModelArrayConverter<U: BaseResponse>: AbstractCallResultConverter<[U]> {

    // MARK: Variables

    private let keyPath: String?
    private let context: MapContext?

    // MARK: Construction

    public init(keyPath: String? = nil, context: MapContext? = nil) {
        self.keyPath = keyPath
        self.context = context

        super.init()
    }

    // MARK: Methods

    open override func convert(object: Any?) throws -> [U] {
        let newBody: [U]

        do {
            // Try to parse response body as JSON array
            var jsonObjects: Any?
            if let keyPath = self.keyPath {
                jsonObjects = (object as? [String: Any])?[keyPath]
            } else {
                jsonObjects = object
            }
            if let jsonObjects = jsonObjects as? [Any] {
                newBody = try jsonObjects.map { (element) in
                    if let jsonObject = element as? [String: Any] {
                        return try U(JSON: jsonObject, context: context)
                    } else {
                        throw ConversionError(reason: "Failed to convert element of array[\(String(describing: index))] to JSON object.")
                    }
                }
            } else {
                throw ConversionError(reason: "Failed to convert response body to JSON array.")
            }
        } catch {
            throw ConversionError(cause: error)
        }

        return newBody
    }
}

// MARK: - AbstractValidatableModelConverter

open class AbstractValidatableModelConverter<U: BaseResponse>: AbstractCallResultConverter<U> {

    // MARK: Variables

    private let keyPath: String?
    private let context: MapContext?

    // MARK: Construction

    public init(keyPath: String? = nil, context: MapContext? = nil) {
        self.keyPath = keyPath
        self.context = context
        super.init()
    }

    // MARK: Methods

    open override func convert(object: Any?) throws -> T {
        let newBody: U

        do {
            // Try to parse response body as JSON object
            var jsonObject: Any?
            if let keyPath = self.keyPath {
                jsonObject = (object as? [String: Any])?[keyPath]
            } else {
                jsonObject = object
            }
            if let jsonObject = jsonObject as? [String: Any] {
                newBody = try U(JSON: jsonObject, context: context)
            } else if let jsonObject = jsonObject, jsonObject is NSNull {
                // Handle empty body
                let emptyJsonObject = [String: Any]()
                newBody = try U(JSON: emptyJsonObject, context: context)
            } else {
                throw ConversionError(reason: "Failed to convert response body to JSON object.")
            }
        } catch {
            throw ConversionError(cause: error)
        }

        return newBody
    }
}
