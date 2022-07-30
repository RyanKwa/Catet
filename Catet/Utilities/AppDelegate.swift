//
//  AppDelegate.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 26/07/22.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    //untuk ngeset notification di app foreground
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    //untuk ngeset notification munculin banner and sound di app foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}
