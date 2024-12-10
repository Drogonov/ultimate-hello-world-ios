//
//  HelloWorldFlowModuleRouting.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 11/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import DI

// sourcery: AutoMockable
public protocol HelloWorldModuleRoutingProtocol {
    func getMagicModuleFactory() -> MVPModuleFactory
    func getAuthModuleFactory() -> MVPModuleFactory
}
