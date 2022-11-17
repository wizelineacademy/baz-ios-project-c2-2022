//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation
import UIKit

///  Protocol to get movie data
protocol MovieDataDelegate{
    func showDataMovies(dataMovie: ResultsMovie, category: String )
}

class MovieAPI {
    public var delegateDataMovie: MovieDataDelegate?
    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let baseURL: String = "https://api.themoviedb.org/3"
    private let imageURL: String = "https://image.tmdb.org/t/p/w500"
    
    /// Request movies
    ///    - category: Represent the name of category, is used to conform the endpoint
    
    func getMovies(category: String) {
        guard let url = URL(string: "\(baseURL)\(category)?api_key=\(apiKey)&language=es") else {return}
        URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
            guard let json = data else{return}
            do{
                let decoder = JSONDecoder()
                let dataMovie = try decoder.decode(ResultsMovie.self, from: json)
                delegateDataMovie?.showDataMovies(dataMovie: dataMovie, category: category)
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
                    print("Ha ocurrido un error: ", error.localizedDescription )
                }
                do {
                    guard let json = data else { return }
                    let movies = try JSONDecoder().decode(ResultsMovie.self, from: json)
                    completion(movies.results)
                } catch {
                    print("Ha ocurrido un error: \(error.localizedDescription)")
                }
            }.resume()
        }
    }
    
    
    public func getMovieCast(idCast: Int, completion: @escaping ([Cast]?) -> ()) {
        if let urlString = URL(string: "\(baseURL)movie/\(idCast)/credits?api_key=\(apiKey)&language=es-MX") {
            URLSession.shared.dataTask(with: urlString) { data, response, error in
                if let error = error {
                    print("Ha ocurrido un error Cast: ", error.localizedDescription )
                }
                do {
                    guard let json = data else { return }
                    let movies = try JSONDecoder().decode(MovieCast.self, from: json)
                    completion(movies.cast)
                } catch {
                    print("Ha ocurrido un error Cast: \(error.localizedDescription)")
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
