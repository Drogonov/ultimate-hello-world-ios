//
//  ChangeLanguageViewStore.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 23/12/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation

class ChangeLanguageViewStore {

    // MARK: Public Properties

    var delegate: ChangeLanguageViewActionProtocol?

    @Published var languages: [LanguageViewModel] = []
    @Published var buttonText: String = .empty
    @Published var isButtonLoading: Bool = false
    @Published var isButtonEnabled: Bool = true
}

// MARK: - ChangeLanguageViewStoreInput

extension ChangeLanguageViewStore: ChangeLanguageViewStoreInput {
    func switchToggled(on index: Int) {
        delegate?.switchToggled(on: index)
    }
    
    func viewButtonTapped() {
        delegate?.viewButtonTapped()
    }

    func update(with viewModel: ChangeLanguageViewModel) {
        languages = viewModel.languages
        buttonText = viewModel.buttonText
        isButtonLoading = viewModel.isButtonLoading
        isButtonEnabled = viewModel.isButtonEnabled
    }
}
