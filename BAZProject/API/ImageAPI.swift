//
//  ImageAPI.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 10/11/22.
//

import Foundation
import UIKit

final class ImageAPI {
    /// Download image
    /// - Parameter name: name of image to download
    /// - Returns: Image of type UIIMage
    static func getImage(with name: String, completion: @escaping (Result<UIImage, Error>) -> Void){
        let image = UIImage(named: "poster") ?? UIImage()
        let urlStr = "https://image.tmdb.org/t/p/w500\(name)"
        guard let url = URL(string: urlStr) else {
            completion(Result.failure(APIError.urlError))
            return
        }
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data else {
                completion(Result.failure(APIError.urlError))
                return
            }
            let imgResult = UIImage(data: data) ?? image
            completion(Result.success(imgResult))
        }.resume()
    }
}
