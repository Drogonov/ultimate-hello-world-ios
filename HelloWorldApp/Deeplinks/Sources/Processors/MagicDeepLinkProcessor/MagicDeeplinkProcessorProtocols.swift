//
//  MagicDeeplinkProcessorProtocols.swift
//  Deeplinks
//
//  Created by Anton Vlezko on 28/09/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import UIKit
import CommonApplication
import Magic

// MARK: - Interactor Protocols

protocol MagicDeeplinkProcessorProtocol: DeeplinkProcessorProtocol {
    func setMagic(dataStorage: MagicDataStorage)
    func openMain()
}

// MARK: - Router Protocols

protocol MagicDeeplinkRouterProtocol: BaseRouterInput {
    func showMagic(dataStorage: MagicDataStorage, moduleOutput: MagicModuleOutput)
    func goToMain()
}
