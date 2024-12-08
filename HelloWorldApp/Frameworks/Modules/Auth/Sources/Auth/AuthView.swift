import SwiftUI
import Combine

// MARK: - AuthView

struct AuthView: View {

    // MARK: Properties

    @ObservedObject var model: AuthViewModel
    var buttonTapped: () -> Void

    @FocusState private var focusedField: FocusableField?

    // MARK: Construction

    var body: some View {
        ScrollView {
            VStack {
                Picker(Constants.pickerName, selection: $model.authMode) {
                    Text(model.loginPlaceholder).tag(AuthMode.login)
                    Text(model.registerPlaceholder).tag(AuthMode.register)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                TextField(model.emailPlaceholder, text: $model.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($focusedField, equals: .email)
                    .padding()
                    .onSubmit { focusedField = .password }

                SecureField(model.passwordPlaceholder, text: $model.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($focusedField, equals: .password)
                    .padding()
                    .onSubmit {
                        if model.authMode == .register {
                            focusedField = .confirmPassword
                        } else {
                            focusedField = nil
                        }
                    }

                if model.authMode == .register {
                    SecureField(model.confirmPasswordPlaceholder, text: $model.confirmPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($focusedField, equals: .confirmPassword)
                        .padding()
                        .onSubmit { focusedField = nil }
                }

                Spacer()

                Button(action: {
                    buttonTapped()
                }) {
                    Text(model.buttonText)
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
        }
    }
}

// MARK: - Inner Types

fileprivate extension AuthView {
    enum FocusableField: Hashable {
        case email
        case password
        case confirmPassword
    }
}

// MARK: - Constants

fileprivate extension AuthView {
    enum Constants {
        static let pickerName = "Auth Mode"
    }
}

// MARK: - AuthView_Previews

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        let model = AuthViewModel()

        return AuthView(
            model: model,
            buttonTapped: { }
        )
    }
}
