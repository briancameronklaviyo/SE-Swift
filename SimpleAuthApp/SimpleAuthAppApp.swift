import SwiftUI
import KlaviyoSwift

@main
struct SimpleAuthAppApp: App {
    @StateObject private var authService = AuthService.shared
    
    init() {
        KlaviyoSDK().initialize(with: "Ns5p3C")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authService)
        }
    }
}
