//
//  ExtensionUIViewController.swift
//  BAZProject
//
//  Created by mvazquezl on 24/10/22.
//

import Foundation
import UIKit

extension UIViewController {
    public func basicAlert(title:String, message:String){
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
}
