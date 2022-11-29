//
//  ImageViewExtension.swift
//  BAZProject
//
//  Created by 1028092 on 10/11/22.
//

import Foundation
import UIKit

extension UIImageView: MovieAPIConstantsProtocol {
    
    /// This function receive poster Image of type String
    /// - parameters
    ///      - poster: set string for after get the image generic
    func loadFromNetwork(_ poster: String?) {
        if let setPoster = poster {
            guard let url = URL(string: "\(URLIMAGE)\(setPoster)") else { return }
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                DispatchQueue.main.async {
                    guard let data = data else { print(error?.localizedDescription ?? "Fetch image Error");  return }
                    if let downloadedImage = UIImage(data: data) {
                        self.image = downloadedImage
                    }
                }
            }
            task.resume()
        }
        else
        {
            if let setImageLocal = UIImage(named: "poster")
            {
                self.image = setImageLocal
            }
        }
    }
}


extension String {
    /// This function receive parameter page
    /// - parameters
    ///      - page: set page of list movies
    ///      - return a String how result
    func setUrlMoviePage(_ page: Int) -> String {
        "\(self)&page=\(page)"
    }
    /// This function receive set movieId type String
    /// - parameters
    ///      - movieId: set movieId type String for get the movies
    ///      - return a String how result
    func setMovieID(_ movieId: String) -> String {
        self.replacingOccurrences(of: "{movieID}", with: movieId)
    }
    
    /// This function receive search movie
    /// - parameters
    ///      - setmovie: set url String of the Movie
    ///      - return the url generate
    func setSearchMovieId(_ setMovie: String) -> String {
        "\(self)\(setMovie)"
    }
    
}
