//
//  NetworkServiceErrorHandler.swift
//  Services
//
//  Created by Anton Vlezko on 27/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import DI
import Net
import Persistence

public class NetworkServiceErrorHandler: DefaultErrorHandlerProtocol {
    public var errorReportingType: ErrorReportingType = .alert
    public var sessionCache: CacheProtocol? = resolveDependency(CacheProtocol.self, name: CacherType.session)

    public init() {}
}
