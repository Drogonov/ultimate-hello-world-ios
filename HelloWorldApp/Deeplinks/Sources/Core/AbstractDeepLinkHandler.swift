//
//  AbstractDeeplinkHandler.swift
//  Deeplinks
//
//  Created by Anton Vlezko on 28/09/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import CommonNet

open class AbstractDeeplinkHandler: DeeplinkHandlerProtocol {

    public var next: DeeplinkHandlerProtocol?
    open var linkTypes: Set<DeeplinkType> { [] }

    // MARK: Private properties

    private var currentProcessor: DeeplinkProcessorProtocol?

    public init() { }

    public func handle(linkContent: DeeplinkContent, context: DeeplinkProcessorContext) {
        guard canHandle(linkContent: linkContent) else {
            next?.handle(linkContent: linkContent, context: context)
            return
        }

        let processor = getProcessor(linkContent: linkContent, context: context)
        processor.setContext(context)
        processor.process(linkContent: linkContent)
        currentProcessor = processor
    }

    public func resetProcessors() {
        currentProcessor = nil
    }

    open func canHandle(linkContent: DeeplinkContent) -> Bool {
        linkTypes.contains(linkContent.type)
    }

    open func getProcessor(linkContent: DeeplinkContent, context: DeeplinkProcessorContext) -> DeeplinkProcessorProtocol {
        fatalError("Should override")
    }
}

