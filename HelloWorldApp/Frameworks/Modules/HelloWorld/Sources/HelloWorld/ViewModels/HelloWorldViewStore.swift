//
//  HelloWorldViewStore.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 23/12/24.
//  Copyright © 2024 Smart Lads Software. All rights reserved.
//

import Foundation

class HelloWorldViewStore {

    // MARK: Public Properties

    var delegate: HelloWorldViewActionProtocol?

    @Published var buttonTitle: String = .empty
    @Published var text: String = .empty
}

extension HelloWorldViewStore: HelloWorldViewStoreInput {
    func viewMoreInfoTapped() {
        delegate?.viewMoreInfoTapped()
    }
    
    func update(with viewModel: HelloWorldViewModel) {
        buttonTitle = viewModel.buttonTitle
        text = viewModel.text
    }
}
