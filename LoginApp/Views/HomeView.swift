import SwiftUI

/// Second view: shown after login/register.
struct HomeView: View {
    @Binding var isLoggedIn: Bool

    var body: some View {
        NavigationStack {
            VStack {
                Text("Home")
                    .font(.title)
                Text("You're in. Keep this view minimal and add features as needed.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding()

                Spacer()

                Button("Log Out") {
                    isLoggedIn = false
                }
                .buttonStyle(.bordered)
                .padding(.bottom, 32)
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView(isLoggedIn: .constant(true))
}
