//
//  BottomLabeledTextFieldStyleConfig.swift
//  MasterComponents
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import SwiftUI

public struct BottomLabeledTextFieldStyleConfig: LabeledContentStyle {

    public func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: .zero) {
            configuration.content
            configuration.label
                .font(TextStyle.caption.font)
        }
    }

    public init() {}
}
