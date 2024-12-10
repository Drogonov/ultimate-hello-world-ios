//
//  DefaultErrorHandler.swift
//  Net
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import DI
import Persistence
import CommonApplication

class DefaultErrorHandler: DefaultErrorHandlerProtocol {
    var errorReportingType: ErrorReportingType = .none
    var sessionCache: CacheProtocol? = resolveDependency(CacheProtocol.self, name: CacherType.session)
    var router: BaseRouterInput?

    init(router: BaseRouterInput?) {
        self.router = router
    }
}
