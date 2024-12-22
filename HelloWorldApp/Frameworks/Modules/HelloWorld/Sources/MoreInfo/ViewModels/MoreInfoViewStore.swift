//
//  MoreInfoViewStore.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 23/12/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import SwiftUI

class MoreInfoViewStore {

    // MARK: Public Properties

    var delegate: MoreInfoViewActionProtocol?

    @Published var imageUrl: URL? = nil
    @Published var text: String = .empty
    @Published var buttonTitle: String = .empty
}

// MARK: - MoreInfoViewStoreInput

extension MoreInfoViewStore: MoreInfoViewStoreInput {
    func viewButtonTapped() {
        delegate?.viewButtonTapped()
    }
    
    func update(with viewModel: MoreInfoViewModel) {
        imageUrl = viewModel.imageUrl
        text = viewModel.text
        buttonTitle = viewModel.buttonTitle
    }
}
