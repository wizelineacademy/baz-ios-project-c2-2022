//
//  Networking.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 28/11/22.
//

import Foundation

import Foundation

protocol Networkable {
    func load(request: URLRequest, completion: @escaping (Result<Data, Error>) -> ())
}

struct EnpointCase{
    let name: String
    let request: URLRequest
}

enum EndPoint {
    static let baseURL = "https://api.themoviedb.org/3"
    static let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    case search(String)
    case similar(Int)
    case recommendations(Int)
    case credits(Int)
    case trending
    case popular
    case topRate
    case upcoming
    case nowPlaying
    case reviews(String)
    
//https://api.themoviedb.org/3/movie/603/reviews?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es
    
}

extension EndPoint {
    func getCase() -> EnpointCase {
        switch self {
        case .search(let query):
            guard let url = URL(string: EndPoint.baseURL + "/search/movie?api_key=\(EndPoint.apiKey)&query=\(query)") else { fatalError("URL no valida..") }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            return EnpointCase(name: "", request: request )
        case .similar(let id):
            guard let url = URL(string: EndPoint.baseURL + "/movie/\(id)/similar?api_key=\(EndPoint.apiKey)") else { fatalError("URL no valida..") }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            return EnpointCase(name: "", request: request )
        case .recommendations(let id):
            guard let url = URL(string: EndPoint.baseURL + "/movie/\(id)/recommendations?api_key=\(EndPoint.apiKey)") else { fatalError("URL no valida..") }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            return EnpointCase(name: "", request: request )
        case .credits(let id):
            guard let url = URL(string: EndPoint.baseURL + "/movie/\(id)/credits?api_key=\(EndPoint.apiKey)") else { fatalError("URL no valida..") }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            return EnpointCase(name: "", request: request )
        case .trending:
            guard let url = URL(string: EndPoint.baseURL + "/trending/movie/day?api_key=\(EndPoint.apiKey)") else { fatalError("URL no valida..") }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            return EnpointCase(name: "Tendencias", request: request )
        case .popular:
            guard let url = URL(string: EndPoint.baseURL + "/movie/popular?api_key=\(EndPoint.apiKey)") else { fatalError("URL no valida..") }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            return EnpointCase(name: "Populares", request: request )
        case .topRate:
            guard let url = URL(string: EndPoint.baseURL + "/movie/top_rated?api_key=\(EndPoint.apiKey)") else { fatalError("URL no valida..") }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            return EnpointCase(name: "Mejores valorados", request: request )
        case .upcoming:
            guard let url = URL(string: EndPoint.baseURL + "/movie/upcoming?api_key=\(EndPoint.apiKey)") else { fatalError("URL no valida..") }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            return EnpointCase(name: "Continuar viendo", request: request )
        case .nowPlaying:
            guard let url = URL(string: EndPoint.baseURL + "/movie/now_playing?api_key=\(EndPoint.apiKey)") else { fatalError("URL no valida..") }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            return EnpointCase(name: "Estrenos recientes", request: request )
        case .reviews(let id):
            guard let url = URL(string: EndPoint.baseURL + "/movie/\(id)/reviews?api_key=\(EndPoint.apiKey)") else { fatalError("URL no valida..") }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            return EnpointCase(name: "Estrenos recientes", request: request )
        }
    }
}

struct ClientAPI: Networkable {
    private let session: URLSession = URLSession(configuration: .default)
    func load(request: URLRequest, completion: @escaping (Result<Data, Error>) -> ()) {
        guard Reachability.isConnectedToNetwork() else{
            completion(.failure(CustomError.noConnection))
            return
        }
        session.dataTask(with: request){ data, response, error in
            if let error = error {
                debugPrint(error)
                completion(.failure(CustomError.noData))
                return
            }
            if let data = data {
                completion(.success(data))
            }
        }.resume()
    }
}
