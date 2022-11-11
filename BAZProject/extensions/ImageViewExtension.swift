//
//  ImageViewExtension.swift
//  BAZProject
//
//  Created by 1028092 on 10/11/22.
//

import Foundation
import UIKit

extension UIImageView: MovieAPIConstantsProtocol {
    
    func loadFromNetwork(_ poster: String) {
        guard let url = URL(string: "\(URLIMAGE)\(poster)") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                guard let data = data else { print(error?.localizedDescription ?? "Fetch image Error"); return }
                if let downloadedImage = UIImage(data: data) {
                    self.image = downloadedImage
                }
            }
        }
        task.resume()
    }
}
