//
//  ___FILEBASENAME___Protocols.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import DI
import MasterComponents
import CommonApplication

// MARK: - Module Protocols

public protocol ___VARIABLE_productName___ModuleInput: MVPModuleInputProtocol {
    func set(dataStorage: ___VARIABLE_productName___DataStorage)
}

// sourcery: AutoMockable
public protocol ___VARIABLE_productName___ModuleOutput: MVPModuleOutputProtocol {}

// MARK: - View Protocols

// sourcery: AutoMockable
protocol ___VARIABLE_productName___ViewInput: AnyObject {
    func setView(with viewModel: ___VARIABLE_productName___ViewModel)
}

// MARK: - Presenter Protocols

// sourcery: AutoMockable
protocol ___VARIABLE_productName___PresenterInput: AnyObject {
    func viewIsReady()
    func viewWillAppear()
    func viewWillDissapear()

    func viewButtonTapped()

    func getEmptyModel() -> ___VARIABLE_productName___ViewModel
}

// MARK: - Router Protocols

// sourcery: AutoMockable
protocol ___VARIABLE_productName___RouterInput: BaseRouterInput {}
