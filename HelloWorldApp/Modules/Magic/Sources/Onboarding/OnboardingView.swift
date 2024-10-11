//
//  OnboardingView.swift
//  Magic
//
//  Created by Anton Vlezko on 11/10/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import SwiftUI
import MasterComponents
import Common

// MARK: - OnboardingView

struct OnboardingView: View {

    // MARK: Properties

    @ObservedObject var model: OnboardingViewModel
    var buttonTapped: () -> Void

    // MARK: Construction

    var body: some View {
        VStack {
            Text(model.text)
                .font(TextStyle.body.font)
                .padding(.vertical, 8)

            Button {
                buttonTapped()
            } label: {
                Text(model.buttonText)
                    .font(TextStyle.body.font)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(
                        Rectangle()
                            .cornerRadius(16)
                            .foregroundColor(.buttonBackgroundColor)
                    )
                    .foregroundColor(.buttonTextColor)
            }
        }
        .padding()
    }
}

// MARK: - Constants

fileprivate extension OnboardingView {

    // delete if not needed
    // enum Constants {}
}

// MARK: - OnboardingView_Previews

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        let model = OnboardingViewModel()
        model.text = "Hello World"

        return OnboardingView(
            model: model,
            buttonTapped: {}
        )
    }
}
