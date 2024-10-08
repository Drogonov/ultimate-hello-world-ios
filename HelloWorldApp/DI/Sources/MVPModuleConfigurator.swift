//
//  File.swift
//  DI
//
//  Created by Anton Vlezko on 12/03/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import UIKit

public class MVPModuleConfigurator {
    private let factory: MVPModuleFactoryProtocol
    private lazy var module: MVPModuleProtocol = {
        factory.instantiateModule()
    }()

    public init(_ factory: MVPModuleFactoryProtocol) {
        self.factory = factory
    }

    @discardableResult
    public func configure<Input, Output>(_ configurator: @escaping (Input?) -> Output?) -> Input? {
        let moduleInput = module.moduleInput
        if let moduleOutput = configurator(moduleInput as? Input) as? MVPModuleOutputProtocol {
            moduleInput?.setModuleOutput(moduleOutput)
        }
        return moduleInput as? Input
    }

    public func getViewController() -> UIViewController {
        guard let viewController = module.viewController() else {
            fatalError("Cannot find UIViewController in MVPModule")
        }
        return viewController
    }
}
