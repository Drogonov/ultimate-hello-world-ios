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

    @ObservedObject var store: OTPViewStore

    // MARK: - Private Properties

    @FocusState private var otpFocusedTextFieldIndex: Int?

    // MARK: Construction

    var body: some View {
        ScrollView {
            VStack(spacing: .zero) {
                Spacer()

                // OTP Input Fields
                HStack(spacing: MCSpacing.spacingM) {
                    ForEach(0..<store.otpTextFields.count, id: \.self) { index in
                        TextField("", text: $store.otpTextFields[index].optionalBind)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                            .frame(height: 64)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .focused($otpFocusedTextFieldIndex, equals: index)
                            .simultaneousGesture(TapGesture().onEnded {
                                store.didTapOTPTextField(with: index)
                            })
                            .onChange(of: store.otpTextFields[index] ?? .empty, { oldValue, newValue in
                                store.didChangeOTPTextField(with: index, text: newValue)
                            })
                            .onChange(of: store.otpFocusedTextFieldIndex) { oldValue, newValue in
                                otpFocusedTextFieldIndex = newValue
                            }
                    }
                }
                .padding(MCSpacing.spacingL)

                Spacer()

                Button(store.verifyButtonText) {
                    store.didTapVerifyButton()
                }
                .loading(store.isVerifyButtonLoading)
                .disabled(!store.isVerifyButtonEnabled)
                .buttonStyle(.main)
                .padding(MCSpacing.spacingL)

                Button(action: {
                    store.didTapResendButton()
                }) {
                    Text(store.resendButtonText)
                        .foregroundStyle(.red)
                        .underline()
                }

                Spacer()
            }
            .onAppear() {
                otpFocusedTextFieldIndex = store.otpFocusedTextFieldIndex
            }
        }
    }
}

// MARK: - OTPView_Previews

struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        let store = OTPViewStore()

        store.verifyButtonText = "Verify"
        store.isVerifyButtonLoading = false
        store.resendButtonText = "Resend OTP"
        store.isVerifyButtonEnabled = false

        store.otpTextFields = [
            0: .empty, 1: .empty, 2: .empty, 3: .empty, 4: .empty, 5: .empty
        ]

        return OTPView(store: store)
    }
}
