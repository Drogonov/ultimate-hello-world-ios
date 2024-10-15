//
//  TopLayerError.swift
//  CommonNet
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

public final class TopLayerError: Error, CustomStringConvertible, CustomDebugStringConvertible {

    // MARK: Properties

    public let error: ErrorResponseMo

    // MARK: Computed Properties

    public var description: String {
        getDescription()
    }

    public var debugDescription: String {
        return self.description
    }

    // MARK: Construction

    required public init(error: BaseResponse) {
        if let error = error as? ErrorResponseMo {
            self.error = error
        } else {
            fatalError("associated error must be of type ErrorResponseMo")
        }
    }

    // MARK: Methods

    public func topLayerErrorResponse() -> ErrorResponseMo? {
        return self.error
    }
}

// MARK: - Private Methods

fileprivate extension TopLayerError {
    func getDescription() -> String {
        TypeCheckerProvider.shared.typeName(of: self)
    }
}
