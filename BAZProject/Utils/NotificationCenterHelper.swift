//
//  NotificationCenterHelper.swift
//  BAZProject
//
//  Created by 1030364 on 11/11/22.
//

import Foundation

class NotificationCenterHelper {
    static var myNotificationCenter: NotificationCenter = MyNotificationCenter()
    
    static func subscribeToNotification(_ subscriber: AnyObject, with selector: Selector, name: NSNotification.Name) {
        NotificationCenterHelper.myNotificationCenter.addObserver(subscriber, selector: selector, name: name, object: nil)
    }
}

class MyNotificationCenter: NotificationCenter {}
