//
//  ChangeLanguageView.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 10/06/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import SwiftUI
import MasterComponents

// MARK: - ChangeLanguageView

struct ChangeLanguageView: View {

    // MARK: Properties

    @ObservedObject var store: ChangeLanguageViewStore

    // MARK: Construction

    var body: some View {
        List {
            Section() {
                ForEach($store.languages) { $language in
                    Toggle(isOn: $language.isSelected) {
                        Text(language.title)
                    }
                    .onChange(of: language.isSelected) {
                        guard let index = store.languages.firstIndex(where: {
                            $0.id == language.id
                        }) else {
                            return
                        }

                        store.switchToggled(on: index)
                    }
                }
            }

            Section() {
                HStack(alignment: .center) {
                    Spacer()

                    Button(store.buttonText) {
                        store.viewButtonTapped()
                    }
                    .foregroundStyle(.red)

                    Spacer()
                }
            }
        }
    }
}

// MARK: - ChangeLanguageView_Previews

struct ChangeLanguageView_Previews: PreviewProvider {
    static var previews: some View {
        let store = ChangeLanguageViewStore()
        store.buttonText = "Hello World"

        return ChangeLanguageView(store: store)
    }
}
