//
//  Notification.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 26/07/22.
//

import Foundation
import NotificationCenter

class NotificationManager {
    static let instance = NotificationManager()
    func requestNotificationAuthoriziation() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("ERROR Notification Request \(error.localizedDescription)")
            }
            else{
                print("Success")
            }
        }
    }
    func scheduleNotification(task: TaskEntity){
        let content = UNMutableNotificationContent()
        content.title = task.wrappedTitle
        content.body = "It's time to start your task!"
        content.sound = .default

        var trigger: UNNotificationTrigger?
        if let reminder = task.wrappedReminder {
            trigger = UNCalendarNotificationTrigger(
                dateMatching: Calendar.current.dateComponents(
                    [.day,.month,.year,.hour,.minute], from: reminder)
                , repeats: false)
        }
        
        if let trigger = trigger {
            let request = UNNotificationRequest(identifier: task.wrappedId.uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Notification Error \(error.localizedDescription)")
                }
            }
        }
    }
        
    func removeNotifications(task: TaskEntity){
        let taskId = String(task.wrappedId.uuidString)
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [taskId])
    }
    
}
