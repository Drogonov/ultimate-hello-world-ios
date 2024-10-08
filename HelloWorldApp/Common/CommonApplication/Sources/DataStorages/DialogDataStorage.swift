//
//  DialogDataStorage.swift
//  CommonApplication
//
//  Created by Anton Vlezko on 16/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation
import Common

public struct DialogDataStorage {

    // MARK: Properties

    public let title: String
    public let description: String
    public let defaultTitle: String
    public let defaultAction: VoidBlock?
    public let cancelTitle: String?
    public let cancelAction: VoidBlock?

    // MARK: Init

    public init(
        title: String = .init(),
        description: String,
        defaultTitle: String,
        defaultAction: VoidBlock? = nil,
        cancelTitle: String? = nil,
        cancelAction: VoidBlock? = nil
    ) {
        self.title = title
        self.description = description
        self.defaultTitle = defaultTitle
        self.defaultAction = defaultAction
        self.cancelTitle = cancelTitle
        self.cancelAction = cancelAction
    }
}
