//
//  ___VARIABLE_productName___DeeplinkProcessorProtocols.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import CommonApplication

// MARK: - Interactor Protocols

protocol ___VARIABLE_productName___DeeplinkProcessorProtocol: DeeplinkProcessorProtocol {
//    func setTest(dataStorage: TestDataStorage)
    func openMain()
}

// MARK: - Router Protocols

protocol ___VARIABLE_productName___DeeplinkRouterProtocol: BaseRouterInput {
//    func showTest(dataStorage: TestDataStorage, moduleOutput: TestModuleOutput)
    func goToMain()
}
