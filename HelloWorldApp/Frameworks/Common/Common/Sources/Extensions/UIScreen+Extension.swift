//
//  UIScreen+Extension.swift
//  Common
//
//  Created by Anton Vlezko on 12/03/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import UIKit

public extension UIScreen {
    class var screenWidth: CGFloat {
        get {
            return UIScreen.main.bounds.size.width
        }
    }

    class var screenHeight: CGFloat {
        get {
            return UIScreen.main.bounds.size.height
        }
    }
}
