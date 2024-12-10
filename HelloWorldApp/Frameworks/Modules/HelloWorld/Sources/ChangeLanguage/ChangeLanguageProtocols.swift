//
//  ChangeLanguageProtocols.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 10/06/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import DI
import MasterComponents
import Services
import CommonApplication

// MARK: - Module Protocols

public protocol ChangeLanguageModuleInput: MVPModuleInputProtocol {
    func set(dataStorage: ChangeLanguageDataStorage)
}

// sourcery: AutoMockable
public protocol ChangeLanguageModuleOutput: MVPModuleOutputProtocol {}

// MARK: - View Protocols

// sourcery: AutoMockable
protocol ChangeLanguageViewInput: AnyObject {
    func setView(with viewModel: ChangeLanguageViewModel)
}

// MARK: - Presenter Protocols

// sourcery: AutoMockable
protocol ChangeLanguagePresenterInput: NativeAlertProtocol {
    func viewIsReady()
    func viewWillAppear()
    func viewWillDissapear()

    func switchToggled(on index: Int)
    func viewButtonTapped()

    func getEmptyModel() -> ChangeLanguageViewModel
}

// MARK: - Router Protocols

// sourcery: AutoMockable
protocol ChangeLanguageRouterInput: BaseRouterInput {
    func gotToAuth()
}
