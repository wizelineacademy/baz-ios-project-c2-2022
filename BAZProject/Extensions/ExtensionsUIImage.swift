//
//  ExtensionsUIImageViewController.swift
//  BAZProject
//
//  Created by mvazquezl on 25/10/22.
//

import Foundation
import UIKit


extension UIImageView {
    
    /**
     Setting the image assigning to the UIImage
     - Parameters:
        - nameImage : A string representing the url of the image
     */
   public func setMovieImage (nameImage: String) {
            let baseURLImage = "https://image.tmdb.org/t/p/w500"
            guard let url = URL(string: "\(baseURLImage)\(nameImage)"),
                    let data = try? Data(contentsOf: url), let expectedImage = UIImage(data: data) else { return }
            self.image = expectedImage
   }
}
