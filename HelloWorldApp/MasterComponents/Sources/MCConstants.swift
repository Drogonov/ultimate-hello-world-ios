//
//  MCConstants.swift
//  MasterComponents
//
//  Created by Anton Vlezko on 27/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import UIKit

public enum MCConstants {

    // Layer properties

    /// 4px
    public static let shimmerLabelCornerRadius: CGFloat = 4

    /// 6px
    public static let smallCornerRadius: CGFloat = 6

    /// 8px
    public static let defaultCornerRadius: CGFloat = 8

    /// 12px
    public static let mediumCornerRadius: CGFloat = 12

    /// 0.5px
    public static let normalBorderWidth: CGFloat = 0.5

    /// 1px
    public static let mediumBorderWidth: CGFloat = 1

    /// 2px
    public static let wideBorderWidth: CGFloat = 2

    /// 4px
    public static let extraWideBorderWidth: CGFloat = 4

    /// Zero
    public static let minAlpha = CGFloat.zero

    /// 0.5
    public static let midAlpha = 0.5

    /// 0.6
    public static let alpha06 = 0.6

    /// 1
    public static let maxAlpha: CGFloat = 1

    // Animations constants

    /// 0.3sec
    public static let standardAnimationDuration: TimeInterval = 0.3
    public static let pressAnimationScaleDownRatio: CGFloat = 0.95

    public static let scaleDownTransform = CGAffineTransform(
        scaleX: MCConstants.pressAnimationScaleDownRatio,
        y: MCConstants.pressAnimationScaleDownRatio
    )
    public static let scaleUpTransform = CGAffineTransform.identity
    public static let scaleAnimationTime: TimeInterval = 0.15
    public static let scaleAnimationOptions: UIView.AnimationOptions = [.curveEaseOut, .allowUserInteraction]
    public static let phoneNumberMask = "+7(___)___-__-__"
}

public typealias MCRadius = MCConstants.Radius
public extension MCConstants {
    enum Radius {

        /// 4
        public static let radiusXS: CGFloat = 4

        /// 8
        public static let radiusS: CGFloat = 8

        /// 12
        public static let radiusM: CGFloat = 12

        /// 18
        public static let radiusL: CGFloat = 18

        /// 24
        public static let radiusXL: CGFloat = 24
    }
}

public typealias MCSpacing = MCConstants.Spacing
public extension MCConstants {
    enum Spacing {

        /// 2
        public static let spacingXXS: CGFloat = 2

        /// 4
        public static let spacingXS: CGFloat = 4

        /// 8
        public static let spacingS: CGFloat = 8

        /// 10
        public static let spacingMS: CGFloat = 10

        /// 12
        public static let spacingM: CGFloat = 12

        /// 16
        public static let spacingL: CGFloat = 16

        /// 20
        public static let spacingXL: CGFloat = 20

        /// 24
        public static let spacing2XL: CGFloat = 24

        /// 28
        public static let spacing3XL: CGFloat = 28

        /// 32
        public static let spacing4XL: CGFloat = 32

        /// 48
        public static let spacing5XL: CGFloat = 48
    }
}

