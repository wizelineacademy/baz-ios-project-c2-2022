//
//  CachedImageMovie.swift
//  BAZProject
//
//  Created by 1017143 on 17/10/22.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    /// Allows downloading and displaying an image in a UIImageView.
    ///
    /// - Parameter urlStr: A string representing the url of the image to download
    func loadImage(urlStr: String) {
        image = UIImage()
        if let img = imageCache.object(forKey: NSString(string: urlStr)) {
            image = img
            return
        }
        guard let url = URL(string: urlStr) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let err = error {
                debugPrint(err)
            } else {
                DispatchQueue.main.async {
                    guard let data = data,
                          let tempImg = UIImage(data: data) else { return }
                    self.alpha = 0.3
                    self.image = tempImg
                    UIView.animate(withDuration: 1.5) {
                        self.alpha = 1.0
                    }
                    imageCache.setObject(tempImg, forKey: NSString(string: urlStr))
                }
            }
        }.resume()
    }
}
