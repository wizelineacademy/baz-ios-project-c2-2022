//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation
import UIKit

class MovieAPI {
    
    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let baseURL: String = "https://api.themoviedb.org/3"
    private let imageURL: String = "https://image.tmdb.org/t/p/w500"
    
    ///binding TrendingViewController to this view model
    var refreshData = {()->() in }
    
    var dataMovie : ResultsMovie? {
        didSet{
            refreshData()
        }
    }
    
    func getMovies() {
        guard let url = URL(string: "\(baseURL)/trending/movie/day?api_key=\(apiKey)") else {return}
        URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
            guard let json = data else{return}
            do{
                let decoder = JSONDecoder()
                self.dataMovie = try decoder.decode(ResultsMovie.self, from: json)
            }catch let error{
                print("Ha ocurrido un error: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    /// - Parameter urlImage: String with the url of the image to download
    /// - Return:  information of the downloaded image of type Data
    
    func getImage(urlImage: String) -> Data {
        let urlImage = "\(imageURL)\(urlImage)"
        guard let urlData = URL(string: urlImage),
              let data = try? Data(contentsOf: urlData) else { return Data() }
        return data
    }
}
