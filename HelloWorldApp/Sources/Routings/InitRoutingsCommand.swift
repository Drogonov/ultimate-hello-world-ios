//
//  InitRoutingsCommand.swift
//  HelloWorldApp
//
//  Created by Anton Vlezko on 11/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import Swinject
import DI

public final class InitRoutingsCommand: Command {
    public func execute() {
        initalizeRoutingsAssemblies()
    }

    public init() {}
}

fileprivate extension InitRoutingsCommand {
    func initalizeRoutingsAssemblies() {
        DIAssembler.apply([
            HelloWorldAppRoutingConfigurator()
        ])
    }
}

