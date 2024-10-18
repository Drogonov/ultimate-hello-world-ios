//
//  FatalErrorWithTypeProvider.swift
//  Common
//
//  Created by Anton Vlezko on 16/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation

// MARK: - FatalErrorWithTypeProviderProtocol

protocol FatalErrorWithTypeProviderProtocol: AnyObject {
    func fatalErrorWithType(
        _ message: @autoclosure () -> String,
        file: StaticString,
        line: UInt
    ) -> Never
}

// MARK: - Service

public class FatalErrorWithTypeProvider {

    static public let shared = FatalErrorWithTypeProvider()

    // MARK: Properties

    private var isRunningXCTest: Bool {
        // How to let the app know if its running Unit tests in a pure Swift project?
        // @link https://stackoverflow.com/a/29991529
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }

    // MARK: Construction

    private init() {}
}

// MARK: - FatalErrorWithTypeProviderProtocol

extension FatalErrorWithTypeProvider: FatalErrorWithTypeProviderProtocol {
    public func fatalErrorWithType(
        _ message: @autoclosure () -> String = "",
        file: StaticString = #file,
        line: UInt = #line
    ) -> Never {
        let logMessage = "Fatal error: \(message())\nFile: \(file)\nLine: \(line)"

#if DEBUG
        if isRunningXCTest {
            FatalErrorException(reason: logMessage, userInfo: nil).raise()
        } else {
            preconditionFailure(logMessage)
        }
#else
        FatalErrorException(reason: logMessage, userInfo: nil).raise()
#endif

        // Suppress error "Return from a ‘noreturn’ function"
        Swift.fatalError(logMessage)
    }
}
