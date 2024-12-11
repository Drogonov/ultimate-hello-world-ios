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
    var verifyTapped: (String) -> Void
    var resendTapped: () -> Void

    // MARK: State

    @State private var otpCode: [String] = Array(repeating: "", count: 6)
    @FocusState private var focusedIndex: Int?

    // MARK: Construction

    var body: some View {
        ScrollView {
            VStack(spacing: .zero) {
                Spacer()

                // OTP Input Fields
                HStack(spacing: MCSpacing.spacingM) {
                    ForEach(0..<6, id: \.self) { index in
                        TextField("", text: Binding(
                            get: { otpCode[index] },
                            set: { newValue in
                                if newValue.count <= 1,
                                   newValue.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil {
                                    otpCode[index] = newValue
                                    if newValue != "" {
                                        focusedIndex = index + 1 < 6 ? index + 1 : nil
                                    }
                                }
                            }
                        ))
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .frame(height: 64)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .focused($focusedIndex, equals: index)
                    }
                }
                .padding(MCSpacing.spacingL)

                Spacer()

                Button(model.verifyButtonText) {
                    let otp = otpCode.joined()
                    verifyTapped(otp)
                }
                .loading(model.isVerifyButtonLoading)
                .disabled(otpCode.joined().count < 6)
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

// MARK: - OTPView_Previews

struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        let model = OTPViewModel()
        model.text = "Enter OTP"

        model.verifyButtonText = "Verify"
        model.isVerifyButtonLoading = false
        model.resendButtonText = "Resend OTP"

        return OTPView(
            model: model,
            verifyTapped: { _ in },
            resendTapped: {}
        )
    }
}
