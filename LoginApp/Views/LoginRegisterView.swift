import SwiftUI

/// First screen: simple Login / Register. No backend; tapping Continue sets isLoggedIn.
struct LoginRegisterView: View {
    @Binding var isLoggedIn: Bool
    @State private var mode: AuthMode = .login
    @State private var email = ""
    @State private var password = ""

    enum AuthMode: String, CaseIterable {
        case login = "Login"
        case register = "Register"
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Picker("Mode", selection: $mode) {
                    ForEach(AuthMode.allCases, id: \.self) { Text($0.rawValue).tag($0) }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()

                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)

                Button(mode == .login ? "Log In" : "Register") {
                    isLoggedIn = true
                }
                .buttonStyle(.borderedProminent)
                .padding(.top, 8)

                Spacer()
            }
            .padding()
            .navigationTitle(mode == .login ? "Log In" : "Register")
        }
    }
}

#Preview {
    LoginRegisterView(isLoggedIn: .constant(false))
}
