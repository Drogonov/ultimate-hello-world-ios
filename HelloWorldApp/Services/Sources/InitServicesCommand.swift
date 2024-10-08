//
//  InitServicesCommand.swift
//  Services
//
//  Created by Anton Vlezko on 26/07/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Swinject
import DI

public final class InitServicesCommand: Command {
    public func execute() {
        initalizeServiceAssemblies()
    }

    public init() {}
}

fileprivate extension InitServicesCommand {
    func initalizeServiceAssemblies() {
        DIAssembler.apply([
            ServiceConfigurator()
        ])
    }
}
