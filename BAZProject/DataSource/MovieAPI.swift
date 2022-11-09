//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

final class MovieAPI {

    private let apiKey: String = "api_key".localized
    private let baseUrl: String = "url_api".localized
    private let baseUrlImg: String = "url_img".localized

    /// Make an API request by category
    ///
    /// - Parameters:
    ///    - category: Represent the name of category, is used to conform the endpoint
    ///    - completionHandler: Represent the closure to retrive the response
    func getMovies(category: String, completionHandler: @escaping ([Movie]?) -> Void) {
        if let url = URL(string: "\(baseUrl)\(category)?api_key=\(apiKey)&language=es") {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if error != nil {
                    debugPrint("An error has ocurred ", error?.localizedDescription ?? "error")
                }
                do {
                    guard let data = data else { return }
                    let movies = try JSONDecoder().decode(MovieDay.self, from: data)
                    completionHandler(movies.results)
                } catch {
                    debugPrint("An error has ocurred ", error.localizedDescription)
                }
            }.resume()
        }
        completionHandler(nil)
    }
    /// Make an API request by Id movie and section name.
    ///
    /// - Parameters:
    ///   - section:  Represent the name of section (similar or recommended) , is used to conform the endpoint
    ///   - completionHandler:Represent the closure to retrive the response
    func getMoviesSection(section: MovieSections, idMovie: Int, completionHandler: @escaping ([Movie]?) -> Void) {
        if let url = URL(string: "\(baseUrl)/movie/\(idMovie)/\(section.secctionName)?api_key=\(apiKey)&language=es") {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if error != nil {
                    debugPrint("An error has ocurred 😫 ", error?.localizedDescription ?? "error")
                }
                do {
                    guard let data = data else { return }
                    let movies = try JSONDecoder().decode(MovieDay.self, from: data)
                    completionHandler(movies.results)
                } catch {
                    debugPrint("An error has ocurred 🤯", error.localizedDescription)
                }
            }.resume()
        }
        completionHandler(nil)
    }

    /// Make an API request to search movies by word.
    ///
    /// - Parameters:
    ///   - wordToSearch: Represent the word to search in request
    ///   - completionHandler:Represent the closure to retrive the response
    func getMoviesSearched(wordToSearch: String, completionHandler: @escaping ([Movie]?) -> Void) {
        if let url = URL(string: "\(baseUrl)/search/multi?api_key=\(apiKey)&language=es&query=\(wordToSearch)&page=1") {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if error != nil {
                    debugPrint("An error has ocurred 😫 ", error?.localizedDescription ?? "error")
                }
                do {
                    guard let data = data else { return }
                    let movies = try JSONDecoder().decode(MovieDay.self, from: data)
                    completionHandler(movies.results)
                } catch {
                    debugPrint("An error has ocurred 🤯", error.localizedDescription)
                }
            }.resume()
        }
        completionHandler(nil)
    }
    /// Returns the base url of the images for the covers of the movies
    ///
    /// - Returns: The base url of the images.
    func getBaseUrlImg() -> String {
        return baseUrlImg
    }
}
