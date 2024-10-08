//
//  DeeplinkContent.swift
//  Deeplinks
//
//  Created by Anton Vlezko on 27/09/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

public class DeeplinkContent {

    public init(url: URL, type: DeeplinkType, parameters: DeeplinkContentParameters?, option: DeeplinkProcessingOptionType?) {
        self.url = url
        self.type = type
        self.parameters = parameters
        self.processingOption = option
    }

    public init?(urlString: String, isExternal: Bool) {
        guard let parsedLinkContent = transform.transformFromJSON(urlString),
              case .Deeplink(let content) = parsedLinkContent else {
            return nil
        }

        self.isExternal = isExternal
        self.url = content.url
        self.type = content.type
        self.parameters = content.parameters
        self.processingOption = content.processingOption
    }

    public let url: URL
    public let type: DeeplinkType
    public let parameters: DeeplinkContentParameters?
    public private(set) var processingOption: DeeplinkProcessingOptionType?
    public private(set) var isExternal: Bool = false

    public func setProcessingOption(_ option: DeeplinkProcessingOptionType) {
        processingOption = option
    }

    public func setAdditionalPayload(payload: Any?) {
        additionalPayload = payload
    }

    public func extractAdditionalPayload<T>() -> T? {
        return additionalPayload as? T
    }

    public func isUtmAvailable() -> Bool {
        parameters?.utmMedium != nil
        || parameters?.utmSource != nil
        || parameters?.utmContent != nil
        || parameters?.utmCampaign != nil
    }

    private let transform = LinkTransform()
    private var additionalPayload: Any?
}

