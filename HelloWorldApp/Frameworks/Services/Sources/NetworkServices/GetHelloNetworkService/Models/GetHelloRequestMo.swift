//
//  GetHelloRequestMo.swift
//  Services
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import ObjectMapper
import Net

open class GetHelloRequestMo: BaseRequest {

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

fileprivate extension GetHelloRequestMo {
    enum Constants {
        static let languageCode = "languageCode"
    }
}
