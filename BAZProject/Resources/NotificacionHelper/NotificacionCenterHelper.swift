//
//  NotificacionCenterHelper.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 16/11/22.
//

import Foundation

class NotificationCenterHelper{
    static var myNotificationCenter: NotificationCenter = MyNotificationCenter()
    
    static func subscribeToNotification (_ suscriber: AnyObject, with selector: Selector, name: NSNotification.Name) {
        NotificationCenterHelper.myNotificationCenter.addObserver(suscriber, selector: selector, name: name, object: nil)
    }
}

class MyNotificationCenter: NotificationCenter {
    
}
