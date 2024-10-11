//
//  MagicFlowModuleFactory.swift
//  Magic
//
//  Created by Anton Vlezko on 26/07/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Swinject
import DI
import Services

// MARK: - MagicFlowModuleFactory

public class MagicFlowModuleFactory {

    public init() {}

    private static var resolver: Resolver = {
        let configurators: [Assembly] = [
            ServiceConfigurator(),
            MagicConfigurator(),
            OnboardingConfigurator()
        ]

        DIAssembler.apply(configurators)
        return DIAssembler.assembler.resolver
    }()
}

// MARK: - Public Routing

extension MagicFlowModuleFactory {

    public class func magicModule() -> MVPModuleFactory {
        MVPModuleFactory {
            resolver.resolve(MagicViewController.self)!
        }
    }

    public class func onboardingModule() -> MVPModuleFactory {
        MVPModuleFactory {
            resolver.resolve(OnboardingViewController.self)!
        }
    }
}

