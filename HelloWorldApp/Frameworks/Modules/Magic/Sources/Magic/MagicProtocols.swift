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
import Common

// MARK: - Module Protocols

// sourcery: AutoMockable
public protocol MagicModuleOutput: MVPModuleOutputProtocol {
    func magicNavigationItemBackAction(_ completion: VoidBlock?)
}

// MARK: - View Protocols

// sourcery: AutoMockable
protocol MagicViewInput: AnyObject {
    func setView(with viewModel: MagicViewModel)
}

// sourcery: AutoMockable
protocol MagicViewStoreInput: ObservableObject, MagicViewActionProtocol {
    var delegate: MagicViewActionProtocol? { get set }
    func update(with viewModel: MagicViewModel)
}

// sourcery: AutoMockable
protocol MagicViewActionProtocol: AnyObject {
    func viewNavigationItemBackAction(_ completion: VoidBlock?)
    func viewButtonTapped()
}

// MARK: - Presenter Protocols

// sourcery: AutoMockable
protocol MagicPresenterInput: NativeAlertProtocol, MagicViewActionProtocol {
    func viewIsReady()
}

// MARK: - Router Protocols

// sourcery: AutoMockable
protocol MagicRouterInput: BaseRouterInput {}
