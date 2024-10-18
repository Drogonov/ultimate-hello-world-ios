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
            Spacer()

            Text(model.text)
                .font(TextStyle.body.font)
                .multilineTextAlignment(.center)
                .padding(.vertical, MCSpacing.spacingS)

            Spacer()


            Button {
                buttonTapped()
            } label: {
                Text(model.buttonText)
                    .font(TextStyle.body.font)
                    .padding(.vertical, MCSpacing.spacingS)
                    .padding(.horizontal, MCSpacing.spacingL)
                    .background(
                        Rectangle()
                            .cornerRadius(MCSpacing.spacingL)
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
        model.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
        model.buttonText = "Hellow World"

        return OnboardingView(
            model: model,
            buttonTapped: {}
        )
    }
}
