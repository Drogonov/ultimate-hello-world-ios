//
//  MagicDeeplinkRouter.swift
//  Deeplinks
//
//  Created by Anton Vlezko on 28/09/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import DI
import UIKit
import CommonApplication
import Magic

final class MagicDeeplinkRouter: BaseRouter {

    // MARK: Private Properties

    private var navigationController: UINavigationController? {
        if firstNavigationController?.presentedViewController == nil {
            return firstNavigationController
        }
        return sourceViewController?.navigationController ?? firstNavigationController
    }
}

// MARK: - MagicDeeplinkProcessorRouterInput

extension MagicDeeplinkRouter: MagicDeeplinkRouterProtocol {
    func showMagic(dataStorage: MagicDataStorage, moduleOutput: MagicModuleOutput) {
        NavigationStackProvider.shared.set(isNavigationBarHidden: false)
        
        let configurator = MVPModuleConfigurator(MagicFlowModuleFactory.magicModule())
        let viewController = configurator.getViewController()
        configurator.configure { (input: MagicModuleInput?) in
            input?.set(dataStorage: dataStorage)
            input?.setModuleOutput(moduleOutput)
        }
        
        pushOnFirstNavigationController(
            viewController,
            animated: true
        )
    }

    func goToMain() {
        popToRoot(animated: false)
    }
}
