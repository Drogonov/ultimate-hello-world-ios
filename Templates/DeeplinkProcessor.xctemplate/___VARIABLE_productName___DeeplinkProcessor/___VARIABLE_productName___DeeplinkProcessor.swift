//
//  ___VARIABLE_productName___DeeplinkProcessor.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import CommonApplication
import MasterComponents
import CommonNet

final class ___VARIABLE_productName___DeeplinkProcessor: NativeAlertProtocol {

    var router: MagicDeeplinkRouterProtocol!
    weak var moduleOutput: DeeplinkProcessorModuleOutput?
}

// MARK: - MagicDeeplinkProcessorProtocol

extension ___VARIABLE_productName___DeeplinkProcessor: ___VARIABLE_productName___DeeplinkProcessorProtocol {

//    func setTest(dataStorage: TestDataStorage) {
//        router.showTest(dataStorage: dataStorage, moduleOutput: self)
//    }

    func openMain() {
        router.goToMain()
    }
}

// MARK: - DeeplinkProcessorProtocol

extension ___VARIABLE_productName___DeeplinkProcessor: DeeplinkProcessorProtocol {

    func process(linkContent: DeeplinkContent) {
        handle(linkContent: linkContent)
    }
}

// MARK: - Handle Deeplink

extension ___VARIABLE_productName___DeeplinkProcessor {
    func handle(linkContent: DeeplinkContent) {
        switch linkContent.type {
        default: break
//            getTest()
        }
    }

//    func getTest() {
//        let dataStorage = TestDataStorage()
//        setTest(dataStorage: dataStorage)
//    }
}
