//
//  ___VARIABLE_productName___DeeplinkHandler.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import CommonNet

final public class ___VARIABLE_productName___DeeplinkHandler: AbstractDeeplinkHandler {

    public override var linkTypes: Set<DeeplinkType> {
        [.___VARIABLE_productName___]
    }

    public override func getProcessor(
        linkContent: DeeplinkContent,
        context: DeeplinkProcessorContext
    ) -> DeeplinkProcessorProtocol {
        DeeplinkFlowProcessorFactory().getProcessor(linkContent: linkContent)
    }
}
