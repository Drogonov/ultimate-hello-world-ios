//
//  MoreInfoView.swift
//  HelloWorld
//
//  Created by Anton Vlezko on 16/06/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import SwiftUI
import MasterComponents

// MARK: - MoreInfoView

struct MoreInfoView: View {

    // MARK: Properties

    @ObservedObject var store: MoreInfoViewStore

    // MARK: Construction

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {

                HStack {
                    Spacer()

                    AsyncImage(url: store.imageUrl) { image in
                        image.resizable()
                            .frame(width: 200, height: 200)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                            .frame(width: .infinity, height: 200)
                    }
                    .cornerRadius(16)
                    .padding(.vertical, 8)


                    Spacer()
                }

                Text(store.text)
                    .font(TextStyle.body.font)
                    .padding(.vertical, 8)

                HStack {
                    Spacer()

                    Button {
                        store.viewButtonTapped()
                    } label: {
                        Text(store.buttonTitle)
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

                    Spacer()
                }
            }
            .padding()
        }
    }
}

// MARK: - MoreInfoView_Previews

struct MoreInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let store = MoreInfoViewStore()
        store.imageUrl = URL(string: "https://picsum.photos/seed/picsum/200/300")
        store.text = "Lorem Ipsum is simply dummy text of the printing and typesetting"
        store.buttonTitle = "Open Magic Screen"

        return MoreInfoView(store: store)
    }
}
