//
//  HelloWorldModuleRouting.swift
//  App
//
//  Created by Anton Vlezko on 11/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import DI
import Magic
import HelloWorld

class HelloWorldModuleRouting: HelloWorldModuleRoutingProtocol {
    func getMagicModuleFactory() -> MVPModuleFactory {
        MagicFlowModuleFactory.magicModule()
    }
}
