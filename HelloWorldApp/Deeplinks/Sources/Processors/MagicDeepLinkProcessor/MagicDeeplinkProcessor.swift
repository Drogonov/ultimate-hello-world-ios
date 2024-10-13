//
//  MagicDeeplinkProcessor.swift
//  Deeplinks
//
//  Created by Anton Vlezko on 28/09/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import CommonApplication
import MasterComponents
import CommonNet
import Magic

final class MagicDeeplinkProcessor: NativeAlertProtocol {

    var router: MagicDeeplinkRouterProtocol!
    weak var moduleOutput: DeeplinkProcessorModuleOutput?
}

// MARK: - MagicDeeplinkProcessorProtocol

extension MagicDeeplinkProcessor: MagicDeeplinkProcessorProtocol {

    func setMagic(dataStorage: MagicDataStorage) {
        router.showMagic(dataStorage: dataStorage, moduleOutput: self)
    }

    func openMain() {
        router.goToMain()
    }
}

// MARK: - DeeplinkProcessorProtocol

extension MagicDeeplinkProcessor: DeeplinkProcessorProtocol {

    func process(linkContent: DeeplinkContent) {
        handle(linkContent: linkContent)
    }
}

// MARK: - MagicModuleOutput

extension MagicDeeplinkProcessor: MagicModuleOutput {
    func magicNavigationItemBackAction(_ completion: () -> Void) {
        NavigationStackProvider.shared.set(isNavigationBarHidden: true)
        completion()
    }
}

// MARK: - Handle Deeplink

extension MagicDeeplinkProcessor {
    func handle(linkContent: DeeplinkContent) {
        switch linkContent.type {
        case .magic:
            getMagic()
        }
    }

    func getMagic() {
        let dataStorage = MagicDataStorage()
        setMagic(dataStorage: dataStorage)
    }
}
