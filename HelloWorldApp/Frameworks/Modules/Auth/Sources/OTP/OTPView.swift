//
//  OTPView.swift
//  Auth
//
//  Created by Anton Vlezko on 8/12/24.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.
//

import SwiftUI

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
        VStack(spacing: 20) {
            // Title
            Text("Enter OTP")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top, 40)

            // OTP Input Fields
            HStack(spacing: 10) {
                ForEach(0..<6, id: \.self) { index in
                    TextField("", text: Binding(
                        get: { otpCode[index] },
                        set: { newValue in
                            if newValue.count <= 1, newValue.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil {
                                otpCode[index] = newValue
                                if newValue != "" {
                                    focusedIndex = index + 1 < 6 ? index + 1 : nil
                                }
                            }
                        }
                    ))
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                    .frame(width: 40, height: 50)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    .focused($focusedIndex, equals: index)
                }
            }
            .frame(maxWidth: 300)

            // Verify Button
            Button(action: {
                let otp = otpCode.joined()
                verifyTapped(otp)
            }) {
                Text("Verify")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            .disabled(otpCode.joined().count < 6)

            // Resend OTP Button
            Button(action: {
                resendTapped()
            }) {
                Text("Resend OTP")
                    .foregroundColor(.blue)
                    .underline()
            }
            .padding(.bottom, 40)

            Spacer()
        }
        .navigationTitle("OTP Verification")
        .padding()
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

        return OTPView(
            model: model,
            verifyTapped: { _ in },
            resendTapped: {}
        )
    }
}
