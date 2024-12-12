//
//  OTPView.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import SwiftUI
import MasterComponents

// MARK: - OTPView

struct OTPView: View {

    // MARK: Properties

    @ObservedObject var model: OTPViewModel
    var verifyTapped: () -> Void
    var resendTapped: () -> Void

    // MARK: State

    @FocusState private var focusedIndex: Int?

    // MARK: Construction

    var body: some View {
        ScrollView {
            VStack(spacing: .zero) {
                Spacer()

                // OTP Input Fields
                HStack(spacing: MCSpacing.spacingM) {
                    ForEach(0..<model.otpTextFields.count, id: \.self) { index in
                        TextField("", text: $model.otpTextFields[index].optionalBind)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                            .frame(height: 64)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .focused($focusedIndex, equals: index)
                            .simultaneousGesture(TapGesture().onEnded {
                                focusedIndex = index
                            })
                            .onChange(of: model.otpTextFields[index] ?? .empty, { oldValue, newValue in
                                var value: String = .empty
                                var indexToFocus: Int?

                                switch (
                                    newValue.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil,
                                    newValue.count <= 1
                                ) {
                                case (true, true):
                                    value = newValue
                                    indexToFocus = getIndexToFocus(index)

                                case (true, false):
                                    value = String(newValue.last ?? Character(""))
                                    indexToFocus = getIndexToFocus(index)

                                case (false, _):
                                    value = .empty
                                    indexToFocus = index
                                }

                                model.otpTextFields[index] = value
                                focusedIndex = indexToFocus
                            })
                    }
                }
                .padding(MCSpacing.spacingL)

                Spacer()

                Button(model.verifyButtonText) {
                    verifyTapped()
                }
                .loading(model.isVerifyButtonLoading)
                .disabled(!model.isVerifyButtonEnabled)
                .buttonStyle(.main)
                .padding(MCSpacing.spacingL)

                // Resend OTP Button
                Button(action: {
                    resendTapped()
                }) {
                    Text(model.resendButtonText)
                        .foregroundStyle(.red)
                        .underline()
                }

                Spacer()
            }
        }
        .onAppear {
            focusedIndex = 0
        }
    }
}

// MARK: - Private Methods

fileprivate extension OTPView {
    func getIndexToFocus(_ currentIndex: Int) -> Int? {
        var indexToFocus: Int?

        if !ifAllSymbolsAdded(), currentIndex + 1 == 6 {
            indexToFocus = nil
        } else {
            indexToFocus = currentIndex + 1
        }

        return indexToFocus
    }

    func ifAllSymbolsAdded() -> Bool {
        model.otpTextFields.values.joined().trim().count == 6
    }
}

// MARK: - OTPView_Previews

struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        let model = OTPViewModel()

        model.verifyButtonText = "Verify"
        model.isVerifyButtonLoading = false
        model.resendButtonText = "Resend OTP"
        model.isVerifyButtonEnabled = false

        model.otpTextFields = [
            0: .empty, 1: .empty, 2: .empty, 3: .empty, 4: .empty, 5: .empty
        ]

        return OTPView(
            model: model,
            verifyTapped: {},
            resendTapped: {}
        )
    }
}
