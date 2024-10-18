//
//  GetCountriesResponseMo.swift
//  CommonNet
//
//  Created by Anton Vlezko on 30/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import ObjectMapper

public class GetCountriesResponseMo: BaseResponse {

    /// Countries title
    public private(set) var title: String?

    /// Countries array
    public private(set) var countries: [CountryMo]?

    required public init(map: Map) throws {
        title = try? map.value(Constants.title)
        countries = try? map.value(Constants.countries)

        try super.init(map: map)
    }

    override public func mapping(map: Map) {
        super.mapping(map: map)
        title >>> map[Constants.title]
        countries >>> map[Constants.countries]
    }
}

// MARK: - Constants

fileprivate extension GetCountriesResponseMo {
    enum Constants {
        static let title = "title"
        static let countries = "countries"
    }
}
