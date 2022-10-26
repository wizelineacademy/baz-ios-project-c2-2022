//
//  ExtensionsUIImageViewController.swift
//  BAZProject
//
//  Created by mvazquezl on 25/10/22.
//

import Foundation
import UIKit


extension UIImage {
   public func getMovieImage (nameImage: String) -> UIImage {
            let baseURLImage = "https://image.tmdb.org/t/p/w500"
            guard let url = URL(string: "\(baseURLImage)\(nameImage)"),
                    let data = try? Data(contentsOf: url) else {
                return UIImage()
            }
            return UIImage(data: data) ?? UIImage()
        }
}
