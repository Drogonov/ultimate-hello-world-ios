//
//  BaseResponse.swift
//  CommonNet
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import ObjectMapper
import Common

/// The abstract base class for data models.
open class BaseResponse: EquatableHashableModel, ImmutableMappable {

    // MARK: Properties

    private var map: Map

    public static var typeName: String {
        return String(describing: self)
    }

    // MARK: Construction

    required public init(map: Map) throws {
        self.map = map
    }
    
    open func mapping(map: Map) {
        // Override in subclass
    }
    
    // MARK: Methods: NSCopying
    
    /// Creates a new instance that’s a copy of the receiver.
    ///
    /// - Parameters:
    ///   - zone: This parameter is ignored. Memory zones are no longer used by Objective-C.
    ///
    /// - Returns:
    ///   A newly created copy of instance of the receiver.
    ///
    open func copy(with zone: NSZone? = nil) -> Any {
        return clone()
    }
    
    /// Returns the object returned by `copy(with:)`.
    ///
    /// - Returns:
    ///   The object returned by the `NSCopying` protocol method `copy(with:)`.
    ///
    open func copy() -> Any {
        return copy(with: nil)
    }
    
    /// Creates a deep copy of the receiver.
    ///
    /// - Returns:
    ///   A newly created copy of instance of the receiver.
    ///
    public final func clone() -> Self {
        let typeOfT = type(of: self)

        do {
            let json = toJSON()
            let object = try typeOfT.init(JSON: json)
            return forceCast(object, to: typeOfT)
        } catch {
            let className = TypeCheckerProvider.shared.reflect(typeOfT).fullName
            FatalErrorWithTypeProvider.shared.fatalErrorWithType(
                "Couldn't clone object ‘\(String(describing: className))’",
                file: #file,
                line: #line
            )
        }
    }
}

// MARK: - Private Methods

fileprivate extension BaseResponse {
    func forceCast<T, U>(_ object: T?, to type: U.Type) -> U {
        return (object as! U)
    }
}
