//
//  Binding+Extension.swift
//  Common
//
//  Created by Anton Vlezko on 12/12/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import SwiftUI

public extension Binding where Value == String? {
    var optionalBind: Binding<String> {
        .init(
            get: {
                wrappedValue ?? .empty
            }, set: {
                wrappedValue = $0
            }
        )
    }
}
