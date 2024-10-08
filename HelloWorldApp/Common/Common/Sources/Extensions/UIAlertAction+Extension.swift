//
//  UIAlertAction+Extension.swift
//  Common
//
//  Created by Anton Vlezko on 27/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import UIKit

public extension Array where Element == UIAlertAction {
    func changeTitleTextColor(_ color: UIColor?) {
        forEach {
            $0.changeTitleTextColor(color)
        }
    }
}

public extension UIAlertAction {
    func changeTitleTextColor(_ color: UIColor?) {
        guard let color = color else {
            return
        }
        setValue(color, forKey: "titleTextColor")
    }
}
