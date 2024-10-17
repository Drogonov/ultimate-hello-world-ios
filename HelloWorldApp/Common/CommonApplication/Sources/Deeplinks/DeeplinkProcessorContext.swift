//
//  DeeplinkProcessorContext.swift
//  CommonApplication
//
//  Created by Anton Vlezko on 17/10/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import UIKit

public struct DeeplinkProcessorContext {

    public init(viewController: UIViewController? = nil, moduleOutput: DeeplinkProcessorModuleOutput? = nil) {
        self.viewController = viewController
        self.moduleOutput = moduleOutput
    }

    // In most cases its enought to configure 'DeeplinkProcessorContext' in any module configurator.
    public weak var viewController: UIViewController?
    public weak var moduleOutput: DeeplinkProcessorModuleOutput?
}

extension DeeplinkProcessorContext: Equatable {

    public static func == (lhs: DeeplinkProcessorContext, rhs: DeeplinkProcessorContext) -> Bool {
        lhs.viewController === rhs.viewController && lhs.moduleOutput === rhs.moduleOutput
    }
}
