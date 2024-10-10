//
//  UIColor+Extension.swift
//  Common
//
//  Created by Anton Vlezko on 12/03/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import UIKit
import SwiftUI
import Resources

public extension UIColor {
    static let surfaceColor = Asset.surfaceColor.color
    static let surfaceSecondaryColor = Asset.surfaceSecondaryColor.color

    static let textPrimaryColor = Asset.textPrimaryColor.color
    static let textSecondaryColor = Asset.textSecondaryColor.color

    static let buttonTextColor = Asset.buttonTextColor.color
    static let buttonBackgroundColor = Asset.buttonBackgroundColor.color

    static let accentColor = Asset.accentColor.color
}

public extension Color {
    static let surfaceColor = Asset.surfaceColor.swiftUIColor
    static let surfaceSecondaryColor = Asset.surfaceSecondaryColor.swiftUIColor

    static let textPrimaryColor = Asset.textPrimaryColor.swiftUIColor
    static let textSecondaryColor = Asset.textSecondaryColor.swiftUIColor

    static let buttonTextColor = Asset.buttonTextColor.swiftUIColor
    static let buttonBackgroundColor = Asset.buttonBackgroundColor.swiftUIColor

    static let accentColor = Asset.accentColor.swiftUIColor
}

public extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

