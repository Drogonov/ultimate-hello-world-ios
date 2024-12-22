//
//  MagicViewStore.swift
//  Magic
//
//  Created by Anton Vlezko on 23/12/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation
import Common

class MagicViewStore {

    // MARK: Public Properties

    var delegate: MagicViewActionProtocol?

    @Published var mainText: String = .empty
    @Published var jokeText: String = .empty
    @Published var infoText: String = .empty
}

extension MagicViewStore: MagicViewStoreInput {
    func viewNavigationItemBackAction(_ completion: VoidBlock?) {
        delegate?.viewNavigationItemBackAction(completion)
    }

    func viewButtonTapped() {
        delegate?.viewButtonTapped()
    }

    func update(with viewModel: MagicViewModel) {
        mainText = viewModel.mainText
        jokeText = viewModel.jokeText
        infoText = viewModel.infoText
    }
}
