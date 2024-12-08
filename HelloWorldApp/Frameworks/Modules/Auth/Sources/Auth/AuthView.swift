import SwiftUI

// MARK: - AuthView

struct AuthView: View {

    // MARK: Properties

    @ObservedObject var model: AuthViewModel
    var buttonTapped: (AuthMode) -> Void

    @State private var authMode: AuthMode = .login
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""

    @FocusState private var focusedField: FocusableField?

    @State private var keyboardOffset: CGFloat = 0 // For keyboard handling

    enum FocusableField: Hashable {
        case email
        case password
        case confirmPassword
    }

    // MARK: Construction

    var body: some View {
        ScrollView {
            VStack {
                Picker("Auth Mode", selection: $authMode) {
                    Text("Login").tag(AuthMode.login)
                    Text("Sign Up").tag(AuthMode.register)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($focusedField, equals: .email)
                    .padding()
                    .onSubmit { focusedField = .password }

                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($focusedField, equals: .email)
                    .padding()
                    .onSubmit { focusedField = .password }

                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($focusedField, equals: .email)
                    .padding()
                    .onSubmit { focusedField = .password }

                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($focusedField, equals: .email)
                    .padding()
                    .onSubmit { focusedField = .password }

                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($focusedField, equals: .email)
                    .padding()
                    .onSubmit { focusedField = .password }

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($focusedField, equals: .password)
                    .padding()
                    .onSubmit {
                        if authMode == .register {
                            focusedField = .confirmPassword
                        } else {
                            focusedField = nil
                        }
                    }

                if authMode == .register {
                    SecureField("Confirm Password", text: $confirmPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($focusedField, equals: .confirmPassword)
                        .padding()
                        .onSubmit { focusedField = nil }
                }

                Button(action: {
                    buttonTapped(authMode)
                }) {
                    Text(authMode == .login ? "Login" : "Register")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()

                Spacer()
            }
            .padding()
            .padding(.bottom, keyboardOffset) // Apply keyboard offset
            .onAppear {
                DispatchQueue.main.async {
                    self.focusedField = .email
                }
            }
        }
    }

    // MARK: Keyboard Handling Method

    func adjustForKeyboard(offset: CGFloat) {
        withAnimation {
            keyboardOffset = offset
        }
    }
}

// MARK: - Constants

fileprivate extension AuthView {

    // delete if not needed
    // enum Constants {}
}

// MARK: - AuthView_Previews

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        let model = AuthViewModel()
        model.text = "Hello World"

        return AuthView(
            model: model,
            buttonTapped: { _ in }
        )
    }
}
