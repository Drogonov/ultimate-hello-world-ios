//
//  MoreInfoDataStorage.swift
//  CommonApplication
//
//  Created by Anton Vlezko on 16/06/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import CommonNet

// MARK: - MoreInfoDataStorage

public struct MoreInfoDataStorage {

    // MARK: Public Properties

    public let response: GetMoreInfoResponseMo?

    // MARK: Init

    public init(
        response: GetMoreInfoResponseMo? = nil
    ) {
        self.response = response
    }
}
