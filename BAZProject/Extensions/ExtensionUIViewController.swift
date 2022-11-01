//
//  ExtensionUIViewController.swift
//  BAZProject
//
//  Created by mvazquezl on 24/10/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    /**
    Presents a basic alert to notify error warning, etc.
     - Parameters:
        - title: A string representing the title of the alert
        - message: A string representing the message that is displayed to you in the alert.
     */
    public func basicAlert(title:String, message:String){
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
}
