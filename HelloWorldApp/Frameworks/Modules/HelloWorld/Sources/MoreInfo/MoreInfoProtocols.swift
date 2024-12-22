//
//  MoreInfoProtocols.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 16/06/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import DI
import MasterComponents
import Services
import CommonApplication

// MARK: - Module Protocols

public protocol MoreInfoModuleInput: MVPModuleInputProtocol {
    func set(dataStorage: MoreInfoDataStorage)
}

// sourcery: AutoMockable
public protocol MoreInfoModuleOutput: MVPModuleOutputProtocol {}

// MARK: - View Protocols

// sourcery: AutoMockable
protocol MoreInfoViewInput: AnyObject {
    func setView(with viewModel: MoreInfoViewModel)
}

// sourcery: AutoMockable
protocol MoreInfoViewStoreInput: ObservableObject, MoreInfoViewActionProtocol {
    var delegate: MoreInfoViewActionProtocol? { get set }
    func update(with viewModel: MoreInfoViewModel)
}

// sourcery: AutoMockable
protocol MoreInfoViewActionProtocol: AnyObject {
    func viewButtonTapped()
}

// MARK: - Presenter Protocols

// sourcery: AutoMockable
protocol MoreInfoPresenterInput: NativeAlertProtocol, MoreInfoViewActionProtocol {
    func viewIsReady()
}

// MARK: - Router Protocols

// sourcery: AutoMockable
protocol MoreInfoRouterInput: BaseRouterInput {
    func goToMagicScreen(dataStorage: MagicDataStorage)
}
