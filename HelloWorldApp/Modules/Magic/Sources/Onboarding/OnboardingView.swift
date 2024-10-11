//
//  OnboardingView.swift
//  Magic
//
//  Created by Anton Vlezko on 11/10/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import SwiftUI

// MARK: - OnboardingView

struct OnboardingView: View {

    // MARK: Properties

    @ObservedObject var model: OnboardingViewModel
    var buttonTapped: () -> Void

    // MARK: Construction

    var body: some View {
        VStack {
            Button {
                buttonTapped()
            } label: {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text(model.text)
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
