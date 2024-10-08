//
//  Resolver+Extension.swift
//  DI
//
//  Created by Anton Vlezko on 12/03/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Swinject

public extension Resolver {
    @discardableResult
    func synchronize() -> Resolver {
        guard let container = self as? Container else {
            fatalError("Cannot resolve Resolver as Container")
        }
        return container.synchronize()
    }
}

public extension Resolver {
    func resolveSafe<Service>(
        _ serviceType: Service.Type = Service.self,
        name: String? = nil,
        functionName: String = #function
    ) -> Service {
        guard let instance = resolve(serviceType, name: name) else {
            var errorDescription = "\(functionName) -> Can't resolve \(String(describing: serviceType))"
            if let name = name {
                errorDescription.append(" named \(name)")
            }
            fatalError(errorDescription)
        }
        return instance
    }

    func resolveSafe<Service, Arg1>(
        _ serviceType: Service.Type,
        name: String? = nil,
        argument: Arg1,
        functionName: String = #function
    ) -> Service {
        guard let instance = resolve(serviceType, name: name, argument: argument) else {
            fatalError("\(functionName) -> Can't resolve \(String(describing: serviceType))")
        }
        return instance
    }

    func resolveSafe<Service, Arg1, Arg2>(
        _ serviceType: Service.Type,
        firstArgument: Arg1,
        secondArgument: Arg2,
        functionName: String = #function
    ) -> Service {
        guard let instance = resolve(serviceType, arguments: firstArgument, secondArgument) else {
            fatalError("\(functionName) -> Can't resolve \(String(describing: serviceType))")
        }
        return instance
    }
}
