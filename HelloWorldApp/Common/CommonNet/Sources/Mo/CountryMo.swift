//
//  CountryMo.swift
//  CommonNet
//
//  Created by Anton Vlezko on 30/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import ObjectMapper

public class CountryMo: BaseResponse {

    /// Country name
    public private(set) var name: String?

    /// Country language name
    public private(set) var languageName: String?

    /// Language code of country
    public private(set) var languageCode: String?

    /// Emoji flag of country
    public private(set) var emoji: String?

    /// Is this country current
    public private(set) var isCurrent: Bool?

    required public init(map: Map) throws {
        name = try? map.value(Constants.name)
        languageName = try? map.value(Constants.languageName)
        languageCode = try? map.value(Constants.languageCode)
        emoji = try? map.value(Constants.emoji)
        isCurrent = try? map.value(Constants.isCurrent)

        try super.init(map: map)
    }

    override public func mapping(map: Map) {
        super.mapping(map: map)
        name >>> map[Constants.name]
        languageName >>> map[Constants.languageName]
        languageCode >>> map[Constants.languageCode]
        emoji >>> map[Constants.emoji]
        isCurrent >>> map[Constants.isCurrent]
    }
}

// MARK: - Constants

fileprivate extension CountryMo {
    enum Constants {
        static let name = "name"
        static let languageName = "languageName"
        static let languageCode = "languageCode"
        static let emoji = "emoji"
        static let isCurrent = "isCurrent"
    }
}
