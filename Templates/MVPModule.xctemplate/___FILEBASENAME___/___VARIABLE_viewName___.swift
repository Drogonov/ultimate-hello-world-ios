//
//  ___VARIABLE_viewName___.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

// MARK: - ___VARIABLE_productName___View

struct ___VARIABLE_productName___View: View {

    // MARK: Properties

    @ObservedObject var model: ___VARIABLE_productName___ViewModel
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

fileprivate extension ___VARIABLE_productName___View {

    // delete if not needed
    // enum Constants {}
}

// MARK: - ___VARIABLE_productName___View_Previews

struct ___VARIABLE_productName___View_Previews: PreviewProvider {
    static var previews: some View {
        let model = ___VARIABLE_productName___ViewModel()
        model.text = "Hello World"

        return ___VARIABLE_productName___View(
            model: model,
            buttonTapped: {}
        )
    }
}
