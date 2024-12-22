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

// sourcery: AutoMockable
protocol ChangeLanguageViewStoreInput: ObservableObject, ChangeLanguageViewActionProtocol {
    var delegate: ChangeLanguageViewActionProtocol? { get set }
    func update(with viewModel: ChangeLanguageViewModel)
}

// sourcery: AutoMockable
protocol ChangeLanguageViewActionProtocol: AnyObject {
    func switchToggled(on index: Int)
    func viewButtonTapped()
}

// MARK: - Presenter Protocols

// sourcery: AutoMockable
protocol ChangeLanguagePresenterInput: NativeAlertProtocol, ChangeLanguageViewActionProtocol {
    func viewIsReady()

    func switchToggled(on index: Int)
    func viewButtonTapped()
}

// MARK: - Router Protocols

// sourcery: AutoMockable
protocol ChangeLanguageRouterInput: BaseRouterInput {
    func gotToAuth()
}
