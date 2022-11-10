//
//  ImageAPI.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 10/11/22.
//

import Foundation
import UIKit

final class ImageAPI: GenericRequestProtocol {
    /// Download image
    /// - Parameter name: name of image to download
    /// - Returns: Image of type UIIMage
    func getImage(with name: String, completion: @escaping (Result<UIImage, Error>) -> Void){
        let image = UIImage(named: "poster") ?? UIImage()
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(name)"),
                let data = try? Data(contentsOf: url) else {
                    completion(Result.failure(APIError.urlError))
                    return
        }
        let imgResult = UIImage(data: data) ?? image
        completion(Result.success(imgResult))
    }
}
