//
//  NotificationCenterHelper.swift
//  BAZProject
//
//  Created by Mayra Brenda Carreño Mondragon on 13/11/22.
//

import Foundation
class NotificationCenterHelper {
    static var myNotificationCenter: NotificationCenter = MyNotificationCenter()
    static func subscribeToNotification(_ subscriber: AnyObject, with selector: Selector, name: NSNotification.Name) {
        NotificationCenterHelper.myNotificationCenter.addObserver(subscriber, selector: selector, name: name, object: nil)
    }
}

class MyNotificationCenter: NotificationCenter {}
