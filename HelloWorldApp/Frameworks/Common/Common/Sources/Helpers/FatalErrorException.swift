//
//  FatalErrorException.swift
//  Common
//
//  Created by Anton Vlezko on 16/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation

/// A fatal error exception which should completely halt the application execution.
open class FatalErrorException: NSException {

    // MARK: Construction

    /// Initializes and returns a newly created exception object.
    ///
    /// - Parameters:
    ///   - reason: A human-readable message string summarizing the reason for the exception.
    ///   - userInfo: A dictionary containing user-defined information relating to the exception.
    ///
    public init(
        reason: String?,
        userInfo: [AnyHashable: Any]? = nil
    ) {
        super.init(
            name: NSExceptionName(
                rawValue: TypeCheckerProvider.shared.typeName(
                    of: FatalErrorException.self
                )
            ),
            reason: reason,
            userInfo: userInfo
        )
    }

    // MARK: Inheritanse

    /// Returns an object initialized from data in a given unarchiver.
    ///
    /// - Parameters:
    ///   - decoder: An unarchiver object.
    ///
    public required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }

    /// Initializes and returns a newly created exception object.
    ///
    /// - Parameters:
    ///   - name: The name of the exception.
    ///   - reason: A human-readable message string summarizing the reason for the exception.
    ///   - userInfo: A dictionary containing user-defined information relating to the exception.
    ///
    internal override init(name: NSExceptionName, reason: String?, userInfo: [AnyHashable: Any]? = nil) {
        super.init(name: name, reason: reason, userInfo: userInfo)
    }
}
