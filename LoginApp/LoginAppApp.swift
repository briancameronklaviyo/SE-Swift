import SwiftUI
import UIKit
import KlaviyoSwift

/// UIKit app lifecycle bridge for SwiftUI. Use this for push registration, notification delegates,
/// and other `UIApplicationDelegate` callbacks when you wire up remote notifications.
final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        KlaviyoSDK().initialize(with: "SC73Zx")
        return true
    }

    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
    }

    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
    }
}

@main
struct LoginAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    /// Tracks whether the user has completed login/register (barebones: no real auth).
    @State private var isLoggedIn = false
    @State private var username = ""
    @State private var password = ""

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                HomeView(isLoggedIn: $isLoggedIn, username: username, password: $password)
            } else {
                LoginRegisterView(isLoggedIn: $isLoggedIn, username: $username, password: $password)
            }
        }
    }
}
