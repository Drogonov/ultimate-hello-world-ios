//
//  SingUpResponseMo.swift
//  CommonNet
//
//  Created by Anton Vlezko on 26/11/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import ObjectMapper

public class SingUpResponseMo: BaseResponse {

    /// Status of response
    public private(set) var status: String?

    required public init(map: Map) throws {
        status = try? map.value(Constants.status)

        try super.init(map: map)
    }

    override public func mapping(map: Map) {
        super.mapping(map: map)
        status >>> map[Constants.status]
    }
}

// MARK: - Constants

fileprivate extension SingUpResponseMo {
    enum Constants {
        static let status = "status"
    }
}
