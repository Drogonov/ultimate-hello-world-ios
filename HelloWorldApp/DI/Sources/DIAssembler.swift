//
//  File.swift
//  DI
//
//  Created by Anton Vlezko on 12/03/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Swinject

public struct DIAssembler {

    public static let container = Container()
    public static let assembler = Assembler(container: container)

    public static var resolver: Resolver {
        return assembler.resolver.synchronize()
    }
}

extension DIAssembler {
    public static func apply(_ assemblies: [Assembly]) {
        assembler.apply(assemblies: assemblies)
        assembler.resolver.synchronize()
    }
}

@inline(__always)
public func dependencyResolver() -> Resolver {
    return DIAssembler.resolver
}

@inline(__always)
public func resolveDependency<T>() -> T? {
    return dependencyResolver().resolve(T.self)
}

@inline(__always)
public func resolveDependency<T>(_ type: T.Type) -> T? {
    return dependencyResolver().resolve(type)
}

@inline(__always)
public func resolveDependency<T>(_ type: T.Type, name: String) -> T? {
    return dependencyResolver().resolve(type, name: name)
}

@inline(__always)
public func resolveSafeDependency<T>(_ type: T.Type, name: String) -> T {
    return dependencyResolver().resolveSafe(type, name: name)
}
