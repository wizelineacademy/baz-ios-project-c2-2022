//
//  NotificationHelper.swift
//  BAZProject
//
//  Created by mvazquezl on 14/11/22.
//

import Foundation

class NotificationCenterHelper {
    
    static var myNotificationCenter: NotificationCenter = MyNotificationCenter()
    
    /**
     Adds an entry to the notification hub to call the launcher provided with the notification.
     - suscriber: The class where the notification will be subscribed
     - selector: Specifies the message that the receiver sends to alert them about the publication of the notification.
     - name: The name of the notice to registrar for delivery to the observer.
     */
    static func subscribeToNotification (_ suscriber: AnyObject, with selector: Selector, name: NSNotification.Name) {
        NotificationCenterHelper.myNotificationCenter.addObserver(suscriber, selector: selector, name: name, object: nil)
    }
    
}

class MyNotificationCenter: NotificationCenter {
    
}
