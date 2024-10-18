//
//  HelloWorldDataStorage.swift
//  CommonApplication
//
//  Created by Anton Vlezko on 12/03/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import CommonNet

// MARK: - HelloWorldDataStorage

public struct HelloWorldDataStorage {

    // MARK: Properties

    public let response: GetHelloResponseMo?

    // MARK: Init

    public init(
        response: GetHelloResponseMo? = nil
    ) {
        self.response = response
    }
}
