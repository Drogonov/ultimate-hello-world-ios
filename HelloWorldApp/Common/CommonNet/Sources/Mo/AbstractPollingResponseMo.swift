//
//  AbstractPollingResponseMo.swift
//  CommonNet
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import ObjectMapper

public protocol AbstractPollingResponseMoProtocol {
    var timeout: Int? { get }
    var retryCount: Int? { get }
}

open class AbstractPollingResponseMo: AbstractResponseMo, AbstractPollingResponseMoProtocol, @unchecked Sendable {

    // MARK: Properties

    // Определенное значение таймаута перед следующим вызовом
    public private(set) var timeout: Int?
    
    // Количество попыток запроса МБ к серверу
    public private(set) var retryCount: Int?
    
    // MARK: Init

    required public init(map: Map) throws {
        timeout = try? map.value(Constants.timeout)
        retryCount = try? map.value(Constants.retryCount)
        
        try super.init(map: map)
    }

    // MARK: Inheritance

    override open func mapping(map: Map) {
        super.mapping(map: map)
        
        timeout <- map[Constants.timeout]
        retryCount <- map[Constants.retryCount]
    }
    
    // MARK: Constants
    
    public enum Constants {
        public static let timeout = "timeout"
        public static let retryCount = "retryCount"
    }
}
