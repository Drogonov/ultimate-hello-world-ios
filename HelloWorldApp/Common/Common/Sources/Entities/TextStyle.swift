//
//  TextStyle.swift
//  Common
//
//  Created by Anton Vlezko on 27/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import UIKit
import SwiftUI

public typealias TextAttributes = [NSAttributedString.Key: Any]

public enum TextStyle: CaseIterable {
    case title
    case body
    case button
    case caption
    case link
}

public extension TextStyle {

    // MARK: Properties

    var attributes: TextAttributes {
        var result: TextAttributes = [:]

        switch self {
        case .title:
            result = [
                .font: UIFont.resolve(fontName: .robotoBLack, size: Size.k34),
                .kern: Kern.k037,
                .paragraphStyle: paragraphStyle(lineHeightMultiple: LineHeight.k101)
            ]

        case .body:
            result = [
                .font: UIFont.resolve(fontName: .robotoRegular, size: Size.k17),
                .kern: -Kern.k041,
                .paragraphStyle: paragraphStyle(lineHeightMultiple: LineHeight.k108)
            ]

        case .button:
            result = [
                .font: UIFont.resolve(fontName: .robotoBold, size: Size.k16),
                .kern: -Kern.k032,
                .paragraphStyle: paragraphStyle(lineHeightMultiple: LineHeight.k105)
            ]

        case .caption:
            result = [
                .font: UIFont.resolve(fontName: .robotoRegular, size: Size.k12),
                .paragraphStyle: paragraphStyle(lineHeightMultiple: LineHeight.k112)
            ]

        case .link:
            result = [
                .font: UIFont.resolve(fontName: .robotoRegular, size: Size.k12),
                .paragraphStyle: paragraphStyle(lineHeightMultiple: LineHeight.k112),
                .foregroundColor: UIColor.secondaryTextColor,
                .underlineColor: UIColor.secondaryTextColor.withAlphaComponent(0.7),
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
        }

        return result
    }

    var uiFont: UIFont {
        attributes[.font] as! UIFont
    }

    var font: Font {
        Font(uiFont)
    }

    private func paragraphStyle(
        lineHeightMultiple: CGFloat,
        lineBreakMode: NSLineBreakMode = .byTruncatingTail,
        alignment: NSTextAlignment = .natural
    ) -> NSMutableParagraphStyle {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        paragraphStyle.lineBreakMode = lineBreakMode
        paragraphStyle.alignment = alignment

        return paragraphStyle
    }

    // MARK: Inner Types

    enum Size {
        static let k10: CGFloat = 10
        static let k11: CGFloat = 11
        static let k12: CGFloat = 12
        static let k13: CGFloat = 13
        static let k14: CGFloat = 14
        static let k15: CGFloat = 15
        static let k16: CGFloat = 16
        static let k17: CGFloat = 17
        static let k18: CGFloat = 18
        static let k20: CGFloat = 20
        static let k22: CGFloat = 22
        static let k24: CGFloat = 24
        static let k34: CGFloat = 34
    }

    /// Line Height Multiple
    enum LineHeight {
        /// 100%
        public static let k100: CGFloat = 1
        /// 99.03%
        static let k099: CGFloat = 0.99
        /// 101.05%
        public static let k101: CGFloat = 1.01
        /// 103.13%
        public static let k103: CGFloat = 1.03
        /// 104.75%
        public static let k105: CGFloat = 1.05
        /// 106.65%
        public static let k107: CGFloat = 1.07
        /// 108.44%
        public static let k108: CGFloat = 1.08
        /// 111.73%
        public static let k112: CGFloat = 1.12
    }

    /// Letter spacing
    enum Kern {
        static let k007: Float = 0.07
        static let k008: Float = 0.08
        static let k012: Float = 0.12
        static let k024: Float = 0.24
        static let k032: Float = 0.32
        static let k035: Float = 0.35
        static let k037: Float = 0.37
        static let k038: Float = 0.38
        static let k041: Float = 0.41
    }
}
