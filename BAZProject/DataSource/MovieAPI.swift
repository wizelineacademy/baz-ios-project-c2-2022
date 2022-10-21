//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class MovieAPI {

    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let baseUrl: String = "https://api.themoviedb.org/3"
    private let baseUrlImg: String = "https://image.tmdb.org/t/p/w500"

    ///Make an API request by category
    func getMovies(category: CategoryMovieType, completionHandler: @escaping ([Movie]?) -> Void){
        if let url = URL(string: "\(baseUrl)\(category.endpoint)?api_key=\(apiKey)") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil{
                    print("Ha ocurrido un error ",error?.localizedDescription ?? "error")
                }
                do {
                    guard let data = data else { return }
                    let movies = try JSONDecoder().decode(MovieDay.self, from: data)
                    completionHandler(movies.results)
                }catch {
                    print("Ha ocurrido un error ",error.localizedDescription)
                }
            }.resume()
            
        }
        completionHandler(nil)
    }

    ///Returns the base url of the images for the covers of the movies
    ///
    ///- Returns: The base url of the images.
    func getBaseUrlImg() -> String {
        return baseUrlImg
    }
}
