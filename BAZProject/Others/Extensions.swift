//
//  Extensions.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 07/11/22.
//

import Foundation
import UIKit

protocol IndicatorActivity {
    var indicator: UIActivityIndicatorView { get }
}

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

extension UIViewController: IndicatorActivity {
    var indicator: UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        return activityIndicator
    }
    
    func showError(with error: APIError) {
        let dialogMessage = UIAlertController(title: error.titleError, message: error.descriptionError, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
            debugPrint("Cerro la alerta")
        })
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true)
    }
}

extension Notification.Name {
    static var notificationName: Notification.Name {
        return .init(rawValue: "contador")
    }
}

func ranmdomInterval(with interval: TimeInterval, and variancia: Double) -> TimeInterval {
    return interval + variancia * Double((Double(arc4random_uniform(1000)) - 500.0) / 500.0)
}
