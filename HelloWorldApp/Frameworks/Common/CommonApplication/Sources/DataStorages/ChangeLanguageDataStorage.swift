//
//  ChangeLanguageDataStorage.swift
//  CommonApplication
//
//  Created by Anton Vlezko on 10/06/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import CommonNet

// MARK: - ChangeLanguageDataStorage

public struct ChangeLanguageDataStorage {

    // MARK: Properties

    public let response: GetCountriesResponseMo?

    // MARK: Init

    public init(
        response: GetCountriesResponseMo? = nil
    ) {
        self.response = response
    }
}
