//
//  ImageViewExtension.swift
//  BAZProject
//
//  Created by Alan Emiliano Ramirez Ayala on 27/10/22.
//

import Foundation
import UIKit

extension UIView {
    /// La funcion addBlurToView le añade el efecto de blur a las vistas
    func addBlurToView() {
        var blurEffect: UIBlurEffect!
        if #available(iOS 10.0, *) {
            blurEffect = UIBlurEffect(style: .dark)
        } else {
            blurEffect = UIBlurEffect(style: .light)
        }
        let blurredEffectedView = UIVisualEffectView(effect: blurEffect)
        blurredEffectedView.frame = self.bounds
        blurredEffectedView.alpha = 0.7
        blurredEffectedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurredEffectedView)
    }
    /// La funcion removeFromView le elimina el blur de las vistas
    func removeBlurFromView() {
        for subview in self.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
    }
    
}
