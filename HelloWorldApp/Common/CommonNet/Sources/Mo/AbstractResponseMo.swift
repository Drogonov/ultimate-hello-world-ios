//
//  AbstractResponseMo.swift
//  CommonNet
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import ObjectMapper

open class AbstractResponseMo: BaseResponse, @unchecked Sendable {
    public private(set) var serverTime_: Date?
    public private(set) var errorResponse: ErrorResponseMo?
    
    required public init(map: Map) throws {
        serverTime_ = try? map.value(Constants.strings.serverTime, using: ServerDateTransform.shared)
        errorResponse = try? map.value(Constants.strings.errorResponseMo)
        
        try super.init(map: map)
    }
    
    override open func mapping(map: Map) {
        super.mapping(map: map)
        
        serverTime_ >>> (map[Constants.strings.serverTime], ServerDateTransform.shared)
        errorResponse >>> map[Constants.strings.errorResponseMo]
    }
    
    // MARK: Constants
    
    private enum Constants {
        enum strings {
            static let serverTime = "_<serverTime>_"
            static let errorResponseMo = "errorResponseMo"
        }
    }
}
