//
//  AuthModuleRoutingProtocol.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import DI

// sourcery: AutoMockable
public protocol AuthModuleRoutingProtocol {
    func getHelloWorldModuleFactory() -> MVPModuleFactory
}
