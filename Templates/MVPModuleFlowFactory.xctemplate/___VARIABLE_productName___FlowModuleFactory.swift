//
//  ___VARIABLE_productName___FlowModuleFactory.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Swinject
import DI
import Services

// MARK: - ___VARIABLE_productName___FlowModuleFactory

public class ___VARIABLE_productName___FlowModuleFactory {

    public init() {}

    private static var resolver: Resolver = {
        let configurators: [Assembly] = [
//            TestConfigurator()
        ]

        DIAssembler.apply(configurators)
        return DIAssembler.assembler.resolver
    }()
}

// MARK: - Public Routing

extension ___VARIABLE_productName___FlowModuleFactory {

//    public class func testModule() -> MVPModuleFactory {
//        MVPModuleFactory {
//            resolver.resolve(TestViewController.self)!
//        }
//    }
}
