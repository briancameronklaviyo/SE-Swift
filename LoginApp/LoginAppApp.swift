import SwiftUI
import UIKit
import UserNotifications
import KlaviyoSwift

/// UIKit app lifecycle bridge for SwiftUI. Handles Klaviyo init, push permission, and device token registration.
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

        let center = UNUserNotificationCenter.current()
        center.delegate = self

        // Register with APNs regardless of notification permission; token delivery is independent.
        DispatchQueue.main.async {
            application.registerForRemoteNotifications()
        }

        center.requestAuthorization(options: [.alert, .sound, .badge]) { _, error in
            if let error {
                print("Push notification authorization error:", error)
            }

            // Register again after authorization so Klaviyo has the latest push authorization status.
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }

        return true
    }

    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        AppDelegate.latestPushToken = deviceToken
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("APNs device token registered:", token)
        KlaviyoSDK().set(pushToken: deviceToken)
    }

    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        let nsError = error as NSError
        switch nsError.code {
        case 3010:
            print("Push notifications are not supported in the iOS Simulator.")
        case 3000:
            print(
                "Push registration failed: missing aps-environment entitlement. " +
                "Enable Push Notifications for bundle ID \(Bundle.main.bundleIdentifier ?? "unknown") " +
                "in Apple Developer, then clean build and reinstall on a physical device."
            )
        default:
            print("application:didFailToRegisterForRemoteNotificationsWithError:", error)
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let handled = KlaviyoSDK().handle(notificationResponse: response, withCompletionHandler: completionHandler)
        if !handled {
            completionHandler()
        }
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.list, .banner, .sound])
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
