//
//  AppStartupFlowBuilder.swift
//  App
//
//  Created by Anton Vlezko on 26/07/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import DI
import Services
import Deeplinks

final class AppStartupFlowBuilder {

    init() {}

    func build() -> [Command] {[
        InitServicesCommand(),
        InitDeeplinksCommand(),
        InitRoutingsCommand()
    ]}
}
