//
//  File.swift
//  DI
//
//  Created by Anton Vlezko on 12/03/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

public protocol MVPModuleFactoryProtocol {
    func instantiateModule() -> MVPModuleProtocol
}

public final class MVPModuleFactory {
    var handler: (() -> MVPModuleProtocol)

    public init(handler: @escaping (() -> MVPModuleProtocol)) {
        self.handler = handler
    }
}

extension MVPModuleFactory: MVPModuleFactoryProtocol {
    public func instantiateModule() -> MVPModuleProtocol {
        return handler()
    }
}
