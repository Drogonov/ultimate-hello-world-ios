//
//  GetMoreInfoRequestMo.swift
//  Services
//
//  Created by Anton Vlezko on 30/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import ObjectMapper
import Net

open class GetMoreInfoRequestMo: BaseRequest {

    public private(set) var languageCode: String?

    public init(
        languageCode: String?
    ) {
        self.languageCode = languageCode

        super.init()
    }

    public required init?(map: Map) {
        fatalError("Not implemented. Use init(...) instead")
    }

    open override func mapping(map: Map) {
        languageCode <- map[Constants.languageCode]
    }
}

// MARK: - Constants

fileprivate extension GetMoreInfoRequestMo {
    enum Constants {
        static let languageCode = "languageCode"
    }
}
