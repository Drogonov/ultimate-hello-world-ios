//
//  UIEdgeInsets+Extension.swift
//  Common
//
//  Created by Anton Vlezko on 27/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import UIKit

public extension UIEdgeInsets {

    init(horizontal value: CGFloat) {
        self.init(top: .zero, left: value, bottom: .zero, right: value)
    }

    init(vertical value: CGFloat) {
        self.init(top: value, left: .zero, bottom: value, right: .zero)
    }

    init(all value: CGFloat) {
        self.init(top: value, left: value, bottom: value, right: value)
    }

    init(topInset: CGFloat = .zero, leftInset: CGFloat = .zero, bottomInset: CGFloat = .zero, rightInset: CGFloat = .zero) {
        self.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    }

    init(vertical: CGFloat, horizontal: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}

