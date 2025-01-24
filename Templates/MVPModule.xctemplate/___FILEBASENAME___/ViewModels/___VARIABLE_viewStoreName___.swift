//
//  ___VARIABLE_viewStoreName___.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

// MARK: - ___VARIABLE_productName___ViewStore

class ___VARIABLE_productName___ViewStore {

    // MARK: Public Properties

    var delegate: ___VARIABLE_productName___ViewActionProtocol?

    @Published var buttonText: String = .empty
}

extension ___VARIABLE_productName___ViewStore: ___VARIABLE_productName___ViewStoreInput {
    func viewButtonTapped() {
        delegate?.viewButtonTapped()
    }

    func update(with viewModel: ___VARIABLE_productName___ViewModel) {
        buttonText = viewModel.pages.first?.buttonText ?? .empty
    }
}
