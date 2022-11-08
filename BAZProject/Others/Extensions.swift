//
//  Extensions.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 07/11/22.
//

import Foundation
import UIKit

extension UIPickerView {
    
    func customPicker() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
}

extension UIButton {
    
    func shakeButton(with angle: Double = 0.04) {
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        animation.values = [-angle, angle]
        animation.autoreverses = true
        animation.duration = ranmdomInterval(with: 0.12, and: 0.025)
        animation.repeatCount = Float(10.0)
        self.layer.add(animation, forKey: "animation")
        
        let animationTwo = CAKeyframeAnimation(keyPath: "transform.translation.y") //transform.rotation.y
        animationTwo.values = [4.0,0.0]
        animationTwo.autoreverses = true
        animationTwo.duration = ranmdomInterval(with: 0.12, and: 0.025)
        animationTwo.repeatCount = Float(10.0)
        self.layer.add(animationTwo, forKey: "animationTwo")
    }
}

func ranmdomInterval(with interval: TimeInterval, and variancia: Double) -> TimeInterval {
    return interval + variancia * Double((Double(arc4random_uniform(1000)) - 500.0) / 500.0)
}
