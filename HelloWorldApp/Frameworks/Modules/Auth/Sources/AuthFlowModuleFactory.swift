//
//  AuthFlowModuleFactory.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import Swinject
import DI
import Services

// MARK: - AuthFlowModuleFactory

public class AuthFlowModuleFactory {

    public init() {}

    private static var resolver: Resolver = {
        let configurators: [Assembly] = [
            AuthConfigurator(),
            OTPConfigurator()
        ]

        DIAssembler.apply(configurators)
        return DIAssembler.assembler.resolver
    }()
}

// MARK: - Public Routing

extension AuthFlowModuleFactory {

    public class func authModule() -> MVPModuleFactory {
        MVPModuleFactory {
            resolver.resolve(AuthViewController.self)!
        }
    }

    public class func otpModule() -> MVPModuleFactory {
        MVPModuleFactory {
            resolver.resolve(OTPViewController.self)!
        }
    }
}
