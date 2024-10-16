//
//  HelloWorldView.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 12/03/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import SwiftUI
import MasterComponents

// MARK: - HelloWorldView

struct HelloWorldView: View {

    // MARK: Properties

    @ObservedObject var model: HelloWorldViewModel

    // MARK: Construction

    var body: some View {
        Text(model.text)
            .font(TextStyle.title.font)
            .padding()

    }
}

// MARK: - Constants

fileprivate extension HelloWorldView {

    // delete if not needed
    // enum Constants {}
}

// MARK: - HelloWorldView_Previews

struct HelloWorldView_Previews: PreviewProvider {
    static var previews: some View {
        let model = HelloWorldViewModel()
        model.text = "🏴󠁧󠁢󠁥󠁮󠁧󠁿 Hello World"

        return HelloWorldView(
            model: model
        )
    }
}
