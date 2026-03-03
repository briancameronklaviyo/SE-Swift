import SwiftUI

@main
struct LoginAppApp: App {
    /// Tracks whether the user has completed login/register (barebones: no real auth).
    @State private var isLoggedIn = false

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                HomeView(isLoggedIn: $isLoggedIn)
            } else {
                LoginRegisterView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}
