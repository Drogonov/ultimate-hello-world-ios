//
//  OnboardingProtocolsProtocols.swift
//  Magic
//
//  Created by Anton Vlezko on 11/10/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import DI
import MasterComponents
import CommonApplication

// MARK: - Module Protocols

public protocol OnboardingModuleInput: MVPModuleInputProtocol {
    func set(dataStorage: OnboardingDataStorage)
}

// sourcery: AutoMockable
public protocol OnboardingModuleOutput: MVPModuleOutputProtocol {}

// MARK: - View Protocols

// sourcery: AutoMockable
protocol OnboardingViewInput: AnyObject {
    func setView(with viewModel: OnboardingViewModel)
}

// sourcery: AutoMockable
protocol OnboardingViewStoreInput: ObservableObject, OnboardingViewActionProtocol {
    var delegate: OnboardingViewActionProtocol? { get set }
    func update(with viewModel: OnboardingViewModel)
}

// sourcery: AutoMockable
protocol OnboardingViewActionProtocol: AnyObject {
    func viewButtonTapped()
}

// MARK: - Presenter Protocols

// sourcery: AutoMockable
protocol OnboardingPresenterInput: OnboardingViewActionProtocol {
    func viewIsReady()
}

// MARK: - Router Protocols

// sourcery: AutoMockable
protocol OnboardingRouterInput: BaseRouterInput {
    func goToMainTabBar()
}
