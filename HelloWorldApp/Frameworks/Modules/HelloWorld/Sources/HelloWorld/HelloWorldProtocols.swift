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

// sourcery: AutoMockable
protocol HelloWorldViewStoreInput: ObservableObject, HelloWorldViewActionProtocol {
    var delegate: HelloWorldViewActionProtocol? { get set }
    func update(with viewModel: HelloWorldViewModel)
}

// sourcery: AutoMockable
protocol HelloWorldViewActionProtocol: AnyObject {
    func viewMoreInfoTapped()
}

// MARK: - Presenter Protocols

// sourcery: AutoMockable
protocol HelloWorldPresenterInput: NativeAlertProtocol, HelloWorldViewActionProtocol {
    func viewIsReady()
}

// MARK: - Router Protocols

// sourcery: AutoMockable
protocol HelloWorldRouterInput: BaseRouterInput {
    func goToMoreInfoModule(dataStorage: MoreInfoDataStorage)
}
