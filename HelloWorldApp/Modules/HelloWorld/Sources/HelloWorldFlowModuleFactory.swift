//
//  HelloWorldFlowModuleFactory.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 26/07/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Swinject
import DI
import Services

// MARK: - HelloWorldFlowModuleFactory

public class HelloWorldFlowModuleFactory {

    public init() {}

    private static var resolver: Resolver = {
        let configurators: [Assembly] = [
            ServiceConfigurator(),
            HelloWorldConfigurator(),
            ChangeLanguageConfigurator(),
            MoreInfoConfigurator()
        ]

        DIAssembler.apply(configurators)
        return DIAssembler.assembler.resolver
    }()
}

// MARK: - Public Routing

extension HelloWorldFlowModuleFactory {

    public class func helloWorldModule() -> MVPModuleFactory {
        MVPModuleFactory {
            resolver.resolve(HelloWorldViewController.self)!
        }
    }

    public class func changeLanguageModule() -> MVPModuleFactory {
        MVPModuleFactory {
            resolver.resolve(ChangeLanguageViewController.self)!
        }
    }

    public class func moreInfoModule() -> MVPModuleFactory {
        MVPModuleFactory {
            resolver.resolve(MoreInfoViewController.self)!
        }
    }
}
