//
//  NotificationCenterHelper.swift
//  BAZProject
//
//  Created by Mayra Brenda Carreño Mondragon on 13/11/22.
//

import Foundation

class NotificationCenterHelper {
    //MARK: - Properties
    static var myNotificationCenter: NotificationCenter = MyNotificationCenter()
    ///     Function that subscribes a notification
    ///    - Parameters:
    ///   - suscriber: the one who subscribes to the notification
    ///    - selector: selector that executes the nofication
    ///   - name: name of the notification
    
    static func subscribeToNotification(_ subscriber: AnyObject, with selector: Selector, name: NSNotification.Name) {
        NotificationCenterHelper.myNotificationCenter.addObserver(subscriber, selector: selector, name: name, object: nil)
    }
}

class MyNotificationCenter: NotificationCenter {}
