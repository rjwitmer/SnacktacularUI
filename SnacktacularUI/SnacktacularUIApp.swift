//
//  SnacktacularUIApp.swift
//  SnacktacularUI
//
//  Created by Bob Witmer on 2023-08-21.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct SnacktacularUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var spotVM = SpotViewModel()
    @StateObject var locationManager = LocationManager()

    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(spotVM)
                .environmentObject(locationManager)
        }
    }
}
