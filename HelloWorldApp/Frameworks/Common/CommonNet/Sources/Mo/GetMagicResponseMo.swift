//
//  GetMagicResponseMo.swift
//  CommonNet
//
//  Created by Anton Vlezko on 30/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import ObjectMapper

public class GetMagicResponseMo: BaseResponse {

    public private(set) var title: String?
    public private(set) var mainText: String?
    public private(set) var jokeText: String?
    public private(set) var infoText: String?

    required public init(map: Map) throws {
        title = try? map.value(Constants.title)
        mainText = try? map.value(Constants.mainText)
        jokeText = try? map.value(Constants.jokeText)
        infoText = try? map.value(Constants.infoText)

        try super.init(map: map)
    }

    override public func mapping(map: Map) {
        super.mapping(map: map)
        title >>> map[Constants.title]
        mainText >>> map[Constants.mainText]
        jokeText >>> map[Constants.jokeText]
        infoText >>> map[Constants.infoText]
    }
}

// MARK: - Constants

fileprivate extension GetMagicResponseMo {
    enum Constants {
        static let title = "title"
        static let mainText = "mainText"
        static let jokeText = "jokeText"
        static let infoText = "infoText"
    }
}
