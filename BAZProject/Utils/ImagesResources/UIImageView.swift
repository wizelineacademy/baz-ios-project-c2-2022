//
//  UIImageView.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 04/11/22.
//

import Foundation
import UIKit


extension UIImageView {

    /// Methodo that obtains the url of an image
         /// - Parameter nameImage : image name
   public func setMovieImage (nameImage: String) {
            let baseURLImage = "https://image.tmdb.org/t/p/w500"
            guard let url = URL(string: "\(baseURLImage)\(nameImage)"),
                    let data = try? Data(contentsOf: url), let expectedImage = UIImage(data: data) else { return }
            self.image = expectedImage
   }
}
