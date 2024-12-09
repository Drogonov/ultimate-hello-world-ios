//
//  MCLoadingButton.swift
//  MasterComponents
//
//  Created by Anton Vlezko on 9/12/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import SwiftUI
import Combine

public struct MainButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        MainButton(configuration: configuration)
    }
}

fileprivate struct MainButton: View {
    @Namespace private var animation
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.isLoading) private var isLoading: Bool

    let configuration: ButtonStyleConfiguration

    var body: some View {
        Group {
            if isLoading {
                ZStack {
                    Circle()
                        .fill(Color.buttonBackgroundColor)
                        .frame(height: 60)

                    ProgressView()
                        .tint(Color.buttonTextColor)
                }
                .matchedGeometryEffect(id: "button", in: animation)
            } else {
                configuration.label
                    .font(TextStyle.body.font)
                    .foregroundStyle(isEnabled ? Color.buttonTextColor : Color.buttonTextColor.opacity(0.3))
                    .frame(maxWidth: .infinity)
                    .padding(MCSpacing.spacingL)
                    .background(
                        RoundedRectangle(cornerRadius: MCSpacing.spacingL)
                            .fill(isEnabled ? Color.buttonBackgroundColor : Color.buttonBackgroundColor.opacity(0.5))
                    )
                    .matchedGeometryEffect(id: "button", in: animation)
            }
        }
    }
}

public extension ButtonStyle where Self == MainButtonStyle {
    static var main: MainButtonStyle {
        MainButtonStyle()
    }
}

public extension Button {
    func loading(_ isLoading: Bool) -> some View {
        self
            .environment(\.isLoading, isLoading)
    }
}

public extension EnvironmentValues {
    var isLoading: Bool {
        get { self[LoadingKey.self] }
        set { self[LoadingKey.self] = newValue }
    }
}

public struct LoadingKey: EnvironmentKey {
    static public let defaultValue: Bool = false
}
