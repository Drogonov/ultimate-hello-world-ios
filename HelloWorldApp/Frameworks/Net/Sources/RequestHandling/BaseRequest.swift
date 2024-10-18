//
//  BaseRequest.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import ObjectMapper

/// Allows to specify custom array transformation type which will
/// be used for generating get parameters string for a certain key.
/// Needed for proper array serialization accordingly to many different server side requrements.
/// Required to implement. Returning an empty dictionary '[:]' will results in
/// default (.enumerated) array transformation use.
public protocol ArrayTransformable {
    func arrayTransforms() -> [String: ArrayTransformType]
}

open class BaseRequest: Mappable, ArrayTransformable {

    required public init?(map: Map) { }

    public init() {
        // ...
    }

    open func mapping(map: Map) {
        fatalError("Must be implemented in subclasses")
    }

    /// Override this method in subclasses if you need to return custom array transforms for some fields
    open func arrayTransforms() -> [String: ArrayTransformType] {
        return [:]
    }
}
