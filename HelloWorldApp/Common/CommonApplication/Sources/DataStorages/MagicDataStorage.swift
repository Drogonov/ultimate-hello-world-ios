//
//  MagicDataStorage.swift
//  CommonApplication
//
//  Created by Anton Vlezko on 16/06/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import CommonNet

// MARK: - MagicDataStorage

public struct MagicDataStorage {

    // MARK: Properties

    public let response: GetMagicResponseMo?

    // MARK: Init

    public init(
        response: GetMagicResponseMo? = nil
    ) {
        self.response = response
    }
}
