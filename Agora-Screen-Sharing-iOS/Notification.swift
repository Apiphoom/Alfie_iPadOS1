//
//  Notification.swift
//  Alfie
//
//  Created by Apiphoom Chuenchompoo on 15/6/2563 BE.
//  Copyright © 2563 Agora. All rights reserved.
//

import Foundation
import UserNotifications

class Notification {
    
    class func setNotification (title: String, message: String, time : DateComponents, identifier : String){
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        content.sound = UNNotificationSound.default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: time, repeats: false)
        let center = UNUserNotificationCenter.current()
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content,
                                            trigger: trigger)
        center.add(request, withCompletionHandler: { (error) in
            if error != nil {
                print(error?.localizedDescription ?? "Nil error")
            }
        })
    }
    
}
