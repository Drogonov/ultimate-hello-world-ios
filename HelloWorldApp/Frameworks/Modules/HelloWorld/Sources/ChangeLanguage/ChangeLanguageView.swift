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

    @ObservedObject var model: ChangeLanguageViewModel
    var switchToggled: ((Int) -> Void)
    var buttonTapped: () -> Void

    // MARK: Construction

    var body: some View {
        List {
            Section() {
                ForEach($model.languages) { $language in
                    Toggle(isOn: $language.isSelected) {
                        Text(language.title)
                    }
                    .onChange(of: language.isSelected) {
                        guard let index = model.languages.firstIndex(where: {
                            $0.id == language.id
                        }) else {
                            return
                        }

                        switchToggled(index)
                    }
                }
            }

            Section() {
                HStack(alignment: .center) {
                    Spacer()

                    Button(model.buttonText) {
                        buttonTapped()
                    }
                    .foregroundStyle(.red)

                    Spacer()
                }
            }
        }
    }
}

// MARK: - Constants

fileprivate extension ChangeLanguageView {

    // delete if not needed
    // enum Constants {}
}

// MARK: - ChangeLanguageView_Previews

//struct ChangeLanguageView_Previews: PreviewProvider {
//    static var previews: some View {
//        let model = ChangeLanguageViewModel()
//        model.title = "Hello World"
//
//        return ChangeLanguageView(
//            model: model,
//            buttonTapped: {}
//        )
//    }
//}
