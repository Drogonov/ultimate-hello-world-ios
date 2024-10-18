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

// MARK: - Presenter Protocols

// sourcery: AutoMockable
protocol OnboardingPresenterInput: AnyObject {
    func viewIsReady()
    func viewWillAppear()
    func viewWillDissapear()

    func viewButtonTapped()

    func getEmptyModel() -> OnboardingViewModel
}

// MARK: - Router Protocols

// sourcery: AutoMockable
protocol OnboardingRouterInput: BaseRouterInput {
    func goToMainTabBar()
}
