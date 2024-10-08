//
//  MagicProtocols.swift
//  Magic
//
//  Created by Anton Vlezko on 16/06/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import DI
import MasterComponents
import CommonApplication

// MARK: - Module Protocols

public protocol MagicModuleInput: MVPModuleInputProtocol {
    func set(dataStorage: MagicDataStorage)
}

// sourcery: AutoMockable
public protocol MagicModuleOutput: MVPModuleOutputProtocol {}

// MARK: - View Protocols

// sourcery: AutoMockable
protocol MagicViewInput: AnyObject {
    func setView(with viewModel: MagicViewModel)
}

// MARK: - Presenter Protocols

// sourcery: AutoMockable
protocol MagicPresenterInput: NativeAlertProtocol {
    func viewIsReady()
    func viewWillAppear()
    func viewWillDissapear()

    func getEmptyModel() -> MagicViewModel
}

// MARK: - Router Protocols

// sourcery: AutoMockable
protocol MagicRouterInput: BaseRouterInput {}
