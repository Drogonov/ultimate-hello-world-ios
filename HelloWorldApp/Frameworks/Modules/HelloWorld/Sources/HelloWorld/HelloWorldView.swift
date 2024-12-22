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

    @ObservedObject var store: HelloWorldViewStore

    // MARK: Construction

    var body: some View {
        Text(store.text)
            .font(TextStyle.title.font)
            .padding()

    }
}

// MARK: - HelloWorldView_Previews

struct HelloWorldView_Previews: PreviewProvider {
    static var previews: some View {
        let store = HelloWorldViewStore()
        store.text = "🏴󠁧󠁢󠁥󠁮󠁧󠁿 Hello World"

        return HelloWorldView(store: store)
    }
}
