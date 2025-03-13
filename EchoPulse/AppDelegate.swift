//
//  AppDelegate.swift
//  EchoPulse
//
//  Created by Alexander Dickhans on 2/24/25.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        URLSession.shared.configuration.tlsMinimumSupportedProtocolVersion = .TLSv12
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error requesting permission: \(error.localizedDescription)")
            } else {
                print("Notification permission granted: \(granted)")
            }
        }
        
        return true
    }
//    
//    func application(
//        _ application: UIApplication,
//        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
//    ) {
//        
//        print("Token: ", deviceToken.base64EncodedString())
//    }
}
