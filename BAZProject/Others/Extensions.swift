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
    /// customPicker: picker custom
    func customPicker() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
}

extension UIButton {
    /// shakeButton: Animation to search button
    ///  - Parameter angle: Angle rotation button
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
    /// showError: create and show the error alert view
    /// - Parameter error: enum error by show info
    func showError(with error: APIError) {
        let dialogMessage = UIAlertController(title: error.titleError, message: error.descriptionError, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
            debugPrint("Cerro la alerta")
        })
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true)
    }
    /// moviesCount: search value and up one to save view counts
    func moviesCount() {
        var moviesCount = UserDefaults.standard.integer(forKey: "countMovies")
        moviesCount += 1
        UserDefaults.standard.set(moviesCount, forKey: "countMovies")
    }
}

extension Notification.Name {
    static var countMovieDetails = Notification.Name(rawValue: "countMovies")
}
///ranmdomInterval: Create ramdom interval to animation
/// - Parameter interval:
/// - Parameter variancia: 
func ranmdomInterval(with interval: TimeInterval, and variancia: Double) -> TimeInterval {
    return interval + variancia * Double((Double(arc4random_uniform(1000)) - 500.0) / 500.0)
}

extension UISegmentedControl {
    func changeLineSegment() {
        for segmentItem : UIView in self.subviews {
            for item : Any in segmentItem.subviews {
                if let i = item as? UILabel {
                    i.numberOfLines = 0
                }
            }
        }
    }

}

extension String {
    /// heightWithConstrainedWidth: get dinamic height to text
    ///  - Parameter width: width screen
    ///  - Parameter font: font by calculate height
    func heightWithConstrainedWidth(with width: CGFloat, and font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        return boundingBox.height
    }
}
