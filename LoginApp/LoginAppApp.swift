import SwiftUI
import UIKit
import UserNotifications
import KlaviyoSwift

/// UIKit app lifecycle bridge for SwiftUI. Use this for push registration, notification delegates,
/// and other `UIApplicationDelegate` callbacks when you wire up remote notifications.
final class AppDelegate: NSObject, UIApplicationDelegate {
    /// Stores the most recent APNs token for re-association after identify/login events.
    static var latestPushToken: Data?
    
    static func assignCachedPushTokenIfAvailable() {
        guard let token = latestPushToken else {
            print("No cached APNs token available at login/register time.")
            return
        }
        KlaviyoSDK().set(pushToken: token)
        print("Assigned cached APNs token to current profile.")
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        KlaviyoSDK().initialize(with: "SC73Zx")
        
        // Register with APNs regardless of notification permission; token delivery is independent.
        DispatchQueue.main.async {
            application.registerForRemoteNotifications()
        }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, error in
            if let error {
                print("Push authorization failed: \(error.localizedDescription)")
            }
        }
        
        return true
    }

    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        AppDelegate.latestPushToken = deviceToken
        let tokenHex = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("APNs device token received: \(tokenHex)")
        KlaviyoSDK().set(pushToken: deviceToken)
        print("Assigned APNs token from registration callback.")
    }

    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        print("Failed to register for remote notifications: \(error.localizedDescription)")
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
