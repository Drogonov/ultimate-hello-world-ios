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

// MARK: - Presenter Protocols

// sourcery: AutoMockable
protocol MoreInfoPresenterInput: NativeAlertProtocol {
    func viewIsReady()
    func viewWillAppear()
    func viewWillDissapear()

    func viewButtonTapped()

    func getEmptyModel() -> MoreInfoViewModel
}

// MARK: - Router Protocols

// sourcery: AutoMockable
protocol MoreInfoRouterInput: BaseRouterInput {
    func goToMagicScreen(dataStorage: MagicDataStorage)
}
