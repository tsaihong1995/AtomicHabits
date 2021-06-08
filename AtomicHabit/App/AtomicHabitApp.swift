//
//  AtomicHabitApp.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-02-21.
//

import SwiftUI
import Firebase

@main
struct AtomicHabitApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var userInfo = UserInfo()
    
    var body: some Scene {
        WindowGroup {
            HomePageView().environmentObject(userInfo)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Setting up firebase")
        FirebaseApp.configure()
        return true
    }
}
