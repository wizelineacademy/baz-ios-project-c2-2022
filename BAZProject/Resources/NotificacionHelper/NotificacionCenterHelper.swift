//
//  NotificacionCenterHelper.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 16/11/22.
//

import Foundation

class NotificationCenterHelper{
    static var notificacionCenter: NotificationCenter = myNotficacion()
    
    static func subscribeToNotification (_ suscriber: AnyObject, with selector: Selector, name: NSNotification.Name) {
        NotificationCenterHelper.notificacionCenter.addObserver(suscriber, selector: selector, name: name, object: nil)
    }
}

class myNotficacion: NotificationCenter {
    
}
