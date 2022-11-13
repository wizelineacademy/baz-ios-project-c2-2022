//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation
import UIKit

protocol MovieDataDelegate{
    func showMovies(dataMovie: ResultsMovie)
}

class MovieAPI {
    var delegado: MovieDataDelegate?
    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let baseURL: String = "https://api.themoviedb.org/3"
    private let imageURL: String = "https://image.tmdb.org/t/p/w500"
    
    
    func getMovies() {
        guard let url = URL(string: "\(baseURL)/trending/movie/day?api_key=\(apiKey)") else {return}
        URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
            guard let json = data else{return}
            do{
                let decoder = JSONDecoder()
                let dataMovie = try decoder.decode(ResultsMovie.self, from: json)
                delegado?.showMovies(dataMovie: dataMovie)
                
            }catch let error{
                print("Ha ocurrido un error: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    /// Request to search movies by word.
    /// - Parameters:
    ///   - wordToSearch: word to search in request
    ///   - completionHandler: closure to retrive the response
    
    func getMoviesSearch(wordToSearch: String, completionHandler: @escaping ([Movie]?) -> Void) {
        if let url = URL(string: "\(baseURL)/search/movie?api_key=\(apiKey)&language=es&query=\(wordToSearch)&page=1") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("Ha ocurrido un error Search: ", error?.localizedDescription ?? "error")
                }
                do {
                    guard let json = data else { return }
                    let movies = try JSONDecoder().decode(ResultsMovie.self, from: json)
                    print("Data: ", movies)
                    completionHandler(movies.results)
                } catch {
                    print("Ha ocurrido un error Search: \(error.localizedDescription)")
                }
            }.resume()
        }
        completionHandler(nil)
    }
    
    public func getMovieSection(section: String, idMovie: Int, completion: @escaping ([Movie]?) -> ()){
        if let urlString = URL(string: "\(baseURL)/movie/\(idMovie)/\(section)?api_key=\(apiKey)&language=es") {
            URLSession.shared.dataTask(with: urlString) { data, response, error in
                if let error = error {
                    print("Ha ocurrido un error Search: ", error.localizedDescription )
                }
                do {
                    guard let json = data else { return }
                    let movies = try JSONDecoder().decode(ResultsMovie.self, from: json)
                    print("Data: ", movies)
                    completion(movies.results)
                } catch {
                    print("Ha ocurrido un error Search: \(error.localizedDescription)")
                }
            }.resume()
        }
    }
    
    /// - Parameters:
    ///  - urlImage: String with the url of the image to download
    /// - Return:  information of the downloaded image of type Data
    
    func getImage(urlImage: String) -> Data {
        let urlImage = "\(imageURL)\(urlImage)"
        guard let urlData = URL(string: urlImage),
              let data = try? Data(contentsOf: urlData) else { return Data() }
        return data
    }
}
