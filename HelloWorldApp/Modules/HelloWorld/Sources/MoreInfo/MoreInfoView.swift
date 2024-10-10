//
//  MoreInfoView.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 16/06/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import SwiftUI
import Common

// MARK: - MoreInfoView

struct MoreInfoView: View {

    // MARK: Properties

    @ObservedObject var model: MoreInfoViewModel
    var buttonTapped: () -> Void

    // MARK: Construction

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: model.imageUrl) { image in
                    image.resizable()
                        .frame(width: 200, height: 200)
                        .clipped()
                } placeholder: {
                    ProgressView()
                        .frame(width: 200, height: 200)
                }
                .cornerRadius(16)
                .padding(.vertical, 8)

                Text(model.text)
                    .font(TextStyle.body.font)
                    .padding(.vertical, 8)

                Button {
                    buttonTapped()
                } label: {
                    Text(model.buttonTitle)
                        .font(TextStyle.body.font)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(
                            Rectangle()
                                .cornerRadius(16)
                                .foregroundColor(.buttonBackgroundColor)
                        )
                        .foregroundColor(.buttonTextColor)
                }
            }
            .padding()
        }
    }
}

// MARK: - Constants

fileprivate extension MoreInfoView {

    // delete if not needed
    // enum Constants {}
}

// MARK: - MoreInfoView_Previews

struct MoreInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let model = MoreInfoViewModel()
        model.imageUrl = URL(string: "https://picsum.photos/seed/picsum/200/300")
        model.text = "Lorem Ipsum is simply dummy text of the printing and typesetting"
        model.buttonTitle = "Open Magic Screen"

        return MoreInfoView(
            model: model,
            buttonTapped: {}
        )
    }
}
