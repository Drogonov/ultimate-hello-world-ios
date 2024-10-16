//
//  MagicView.swift
//  Magic
//
//  Created by Anton Vlezko on 16/06/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import SwiftUI
import MasterComponents
import Resources

// MARK: - MagicView

struct MagicView: View {

    // MARK: Properties

    @ObservedObject var model: MagicViewModel
    var buttonTapped: () -> Void

    // MARK: Construction

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(model.mainText)
                    .font(TextStyle.body.font)
                    .padding(.vertical, 8)

                Text(model.jokeText)
                    .font(TextStyle.title.font)
                    .padding(.vertical, 8)

                Text(model.infoText)
                    .font(TextStyle.body.font)
                    .padding(.vertical, 8)

                Spacer()

                HStack {
                    Spacer()

                    Button {
                        buttonTapped()
                    } label: {
                        Text(ResourcesStrings.magicButtonText())
                            .font(TextStyle.body.font)
                            .padding(.vertical, MCSpacing.spacingS)
                            .padding(.horizontal, MCSpacing.spacingL)
                            .background(
                                Rectangle()
                                    .cornerRadius(MCSpacing.spacingL)
                                    .foregroundColor(.buttonBackgroundColor)
                            )
                            .foregroundColor(.buttonTextColor)
                    }
                    .padding()

                    Spacer()
                }
            }
            .padding()
        }
    }
}

// MARK: - Constants

fileprivate extension MagicView {

    // delete if not needed
    // enum Constants {}
}

// MARK: - MagicView_Previews

struct MagicView_Previews: PreviewProvider {
    static var previews: some View {
        let model = MagicViewModel()
        model.mainText = "Hello World"
        model.jokeText = "Hello World"
        model.infoText = "Hello World"

        return MagicView(
            model: model,
            buttonTapped: {}
        )
    }
}
