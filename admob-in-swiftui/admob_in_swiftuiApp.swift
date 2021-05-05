//
//  admob_in_swiftuiApp.swift
//  admob-in-swiftui
//
//  Created by yohei-saito on 2021/05/05.
//

import SwiftUI
import GoogleMobileAds


@main
struct admob_in_swiftuiApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Initialize the Google Mobile Ads SDK.
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
    }
}
