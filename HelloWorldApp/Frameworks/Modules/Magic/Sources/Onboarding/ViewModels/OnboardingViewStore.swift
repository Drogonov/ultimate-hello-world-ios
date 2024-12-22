//
//  OnboardingViewStore.swift
//  Magic
//
//  Created by Anton Vlezko on 23/12/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation

class OnboardingViewStore {

    // MARK: Public Properties

    var delegate: OnboardingViewActionProtocol?

    @Published var text: String = .empty
    @Published var buttonText: String = .empty
}


// MARK: - OnboardingViewStoreInput

extension OnboardingViewStore: OnboardingViewStoreInput {
    func viewButtonTapped() {
        delegate?.viewButtonTapped()
    }

    func update(with viewModel: OnboardingViewModel) {
        text = viewModel.text
        buttonText = viewModel.buttonText
    }
}
