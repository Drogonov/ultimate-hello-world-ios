//
//  UIFont+Extension.swift
//  Common
//
//  Created by Anton Vlezko on 12/03/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import UIKit
import SwiftUI

public extension UIFont {

    /// http://protosketch.io/san-francisco-display-vs-text-compact-vs-normal-a-brief-review/
    static func resolve(
        fontName: DesignFontName,
        size: CGFloat
    ) -> UIFont {
        UIFont(
            name: fontName.rawValue,
            size: size
        ) ?? UIFont.systemFont(
            ofSize: size,
            weight: fontName.appropriateSystemFontWeight
        )
    }

    enum DesignFontName: String, CaseIterable {
        case robotoBLack = "Roboto-Black"
        case robotoBold = "Roboto-Bold"
        case robotoLight = "Roboto-Light"
        case robotoMeduim = "Roboto-Medium"
        case robotoRegular = "Roboto-Regular"
        case robotoThin = "Roboto-Thin"

        var appropriateSystemFontWeight: Weight {
            var result: Weight

            switch self {
            case .robotoBLack, .robotoBold:
                result = .bold

            case .robotoMeduim, .robotoRegular:
                result = .medium

            case .robotoLight, .robotoThin:
                result = .light
            }

            return result
        }
    }
}
