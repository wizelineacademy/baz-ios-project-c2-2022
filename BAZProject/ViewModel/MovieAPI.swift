//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class MovieAPI {
    private let baseUrl: String = "https://api.themoviedb.org/3"
    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    
    var refreshData = { () -> () in }
    
    var api : MovieAPIResponse?{
        didSet {
            refreshData()
        }
    }

    func getMovies(){
        guard let url = URL(string: "\(baseUrl)/trending/movie/day?api_key=\(apiKey)") else { return }
        URLSession.shared.dataTask(with: url){
            (data, response, error) in
            guard let json = data else { return }
            do {
                let decoder = JSONDecoder()
                self.api = try decoder.decode(MovieAPIResponse.self, from: json)
            }catch let error {
                print("Error al cargar la api... \(error)")
            }
        }.resume()
    }
    
    func getNextPage(){
        let nextPage = (api?.page ?? 0) as Int
        guard let url = URL(string: "\(baseUrl)/trending/movie/day?api_key=\(apiKey)&page=\(nextPage + 1)") else { return }
        URLSession.shared.dataTask(with: url){
            (data, response, error) in
            guard let json = data else { return }
            do {
                let decoder = JSONDecoder()
                self.api = try decoder.decode(MovieAPIResponse.self, from: json)
            }catch let error {
                print("Error al cargar la api... \(error)")
            }
        }.resume()
    }

}
