//
//  HelloWorldProtocols.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 12/03/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import DI
import MasterComponents
import Services
import CommonApplication

// MARK: - Module Protocols

public protocol HelloWorldModuleInput: MVPModuleInputProtocol {
    func set(dataStorage: HelloWorldDataStorage)
}

// sourcery: AutoMockable
public protocol HelloWorldModuleOutput: MVPModuleOutputProtocol {}

// MARK: - View Protocols

// sourcery: AutoMockable
protocol HelloWorldViewInput: AnyObject {
    func setView(with viewModel: HelloWorldViewModel)
}

// MARK: - Presenter Protocols

// sourcery: AutoMockable
protocol HelloWorldPresenterInput: NativeAlertProtocol {
    func viewIsReady()
    func viewWillAppear()
    func viewWillDissapear()

    func viewMoreInfoTapped()

    func getEmptyModel() -> HelloWorldViewModel
}

// MARK: - Router Protocols

// sourcery: AutoMockable
protocol HelloWorldRouterInput: BaseRouterInput {
    func goToMoreInfoModule(dataStorage: MoreInfoDataStorage)
}
