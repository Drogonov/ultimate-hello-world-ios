//
//  GetHelloResponseMo.swift
//  CommonNet
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import ObjectMapper

public class GetHelloResponseMo: BaseResponse {

    public private(set) var title: String?
    public private(set) var text: String?
    public private(set) var emoji: String?
    public private(set) var buttonTitle: String?

    required public init(map: Map) throws {
        title = try? map.value(Constants.title)
        text = try? map.value(Constants.text)
        emoji = try? map.value(Constants.emoji)
        buttonTitle = try? map.value(Constants.buttonTitle)

        try super.init(map: map)
    }

    override public func mapping(map: Map) {
        super.mapping(map: map)
        title >>> map[Constants.title]
        text >>> map[Constants.text]
        emoji >>> map[Constants.emoji]
        buttonTitle >>> map[Constants.buttonTitle]
    }
}

// MARK: - Constants

fileprivate extension GetHelloResponseMo {
    enum Constants {
        static let title = "title"
        static let text = "text"
        static let emoji = "emoji"
        static let buttonTitle = "buttonTitle"
    }
}
