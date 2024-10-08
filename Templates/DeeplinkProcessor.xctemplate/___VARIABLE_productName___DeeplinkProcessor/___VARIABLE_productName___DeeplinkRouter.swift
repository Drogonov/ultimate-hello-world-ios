//
//  ___VARIABLE_productName___DeeplinkRouter.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import DI
import UIKit
import CommonApplication
import Magic

final class ___VARIABLE_productName___DeeplinkRouter: BaseRouter {

    // MARK: Private Properties

    private var navigationController: UINavigationController? {
        if firstNavigationController?.presentedViewController == nil {
            return firstNavigationController
        }
        return sourceViewController?.navigationController ?? firstNavigationController
    }
}

// MARK: - ___VARIABLE_productName___DeeplinkRouterProtocol

extension ___VARIABLE_productName___DeeplinkRouter: ___VARIABLE_productName___DeeplinkRouterProtocol {
//    func showTest(dataStorage: TestDataStorage, moduleOutput: TestModuleOutput) {
//        let configurator = MVPModuleConfigurator(TestFlowModuleFactory.testModule())
//        let viewController = configurator.getViewController()
//        configurator.configure { (input: TestModuleInput?) in
//            input?.set(dataStorage: dataStorage)
//            input?.setModuleOutput(moduleOutput)
//        }
//
//        pushOnFirstNavigationController(
//            viewController,
//            animated: true
//        )
//    }

    func goToMain() {
        popToRoot(animated: false)
    }
}
