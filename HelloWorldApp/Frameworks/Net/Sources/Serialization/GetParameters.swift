//
//  GetParameters.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Common

/// 'GET' parameters and array transformation types wrapper
/// If no transform type has passed, default one will be used.
public struct GetParameters {

    public init(_ request: BaseRequest) {
        self.params = request.toJSON()
        self.transforms = request.arrayTransforms()
    }

    public init(_ params: [String: Any?], transforms: [String: ArrayTransformType] = [:]) {
        self.params = removeNilValues(dictionary: params)
        self.transforms = transforms
    }

    public func contains(key: String) -> Bool {
        return self.params.keys.contains { $0 == key }
    }

    public var isEmpty: Bool {
        return self.params.values.isEmpty
    }

    public private(set) var params: [String: Any]

    public private(set) var transforms: [String: ArrayTransformType]
}
