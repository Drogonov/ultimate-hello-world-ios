//
//  MVPModuleProtocol.swift
//  DI
//
//  Created by Anton Vlezko on 12/03/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import UIKit

// MARK: - MVPModuleInputProtocol

public protocol MVPModuleInputProtocol: AnyObject {
    func setModuleOutput(_ moduleOutput: MVPModuleOutputProtocol)
}

public extension MVPModuleInputProtocol {
    func setModuleOutput(_ moduleOutput: MVPModuleOutputProtocol) {}
}

// MARK: - MVPModuleOutputProtocol

public protocol MVPModuleOutputProtocol: AnyObject {}

// MARK: - VIPERModuleProtocol

public protocol MVPModuleProtocol {
    var moduleInput: MVPModuleInputProtocol? { get set }

    func viewController() -> UIViewController?

    func view() -> UIView?
}

public extension MVPModuleProtocol where Self: UIViewController {
    func viewController() -> UIViewController? {
        return self
    }

    func view() -> UIView? {
        nil
    }
}

public extension MVPModuleProtocol where Self: UIView {
    func viewController() -> UIViewController? {
        nil
    }

    func view() -> UIView? {
        self
    }
}
