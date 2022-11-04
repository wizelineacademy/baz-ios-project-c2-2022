//
//  UIImageView.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 04/11/22.
//

import Foundation
import UIKit


extension UIImageView {

   public func setMovieImage (nameImage: String) {
            let baseURLImage = "https://image.tmdb.org/t/p/w500"
            guard let url = URL(string: "\(baseURLImage)\(nameImage)"),
                    let data = try? Data(contentsOf: url), let expectedImage = UIImage(data: data) else { return }
            self.image = expectedImage
   }
}
