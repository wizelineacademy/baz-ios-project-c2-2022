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
    
    /// Request movies
    /// - category:  category by enum MovieSections
    /// - completionHandler: closure to retrive the response
    
    func getMovies(categories: MovieSections, completionHandler: @escaping([Movie]?) -> Void ) {
        guard let url = URL(string: "\(baseURL)\(categories.section)?api_key=\(apiKey)&language=es") else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let json = data else{return}
            do{
                let decoder = JSONDecoder()
                let dataMovie = try decoder.decode(ResultsMovie.self, from: json)
                completionHandler(dataMovie.results)
            }catch let error{
                print("Ha ocurrido un error: \(error.localizedDescription)")
            }
        }.resume()
        completionHandler(nil)
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
    /// Request to sections movies
    /// - Parameters:
    ///   - section: option section
    ///   - idMovie: Id Movie
    ///   - completionHandler: closure to retrive the response
    public func getMovieSection(section: String, idMovie: Int, completion: @escaping ([Movie]?) -> ()) {
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
        completion(nil)
    }
    /// Request  cast movies
    /// - Parameters:
    ///   - idCast: isCast
    ///   - completionHandler: closure to retrive the response
    public func getMovieCast(idCast: Int, completion: @escaping ([Cast]?) -> ()) {
        if let urlString = URL(string: "\(baseURL)movie/\(idCast)/credits?api_key=\(apiKey)&language=es-US") {
            URLSession.shared.dataTask(with: urlString) { data, response, error in
                if let error = error {
                    print("Ha ocurrido un error Cast: ", error.localizedDescription )
                }
                do {
                    guard let json = data else { return }
                    let cast = try JSONDecoder().decode(MovieCast.self, from: json)
                    completion(cast.cast)
                } catch {
                    print("Ha ocurrido un error Cast: \(error.localizedDescription)")
                }
            }.resume()
        }
        completion(nil)
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
