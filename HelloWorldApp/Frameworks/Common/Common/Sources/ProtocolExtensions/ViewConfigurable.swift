//
//  ViewConfigurable.swift
//  Common
//
//  Created by Anton Vlezko on 12/03/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import Foundation

public protocol ViewConfigurable {
    // Add subviews settings and add subviews to parent
    func configureViews()

    // Add constraints to subviews
    func configureConstraints()
}

public extension ViewConfigurable {
    func configure() {
        configureViews()
        configureConstraints()
    }
}
