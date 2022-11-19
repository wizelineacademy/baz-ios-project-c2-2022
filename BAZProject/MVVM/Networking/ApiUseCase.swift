//
//  ApiUseCase.swift
//  BAZProject
//
//  Created by victor manzanero on 07/11/22.
//

import Foundation

protocol ApiUseCaseProtocol {
    func getMovie(success: @escaping ([MovieEntity]?) -> Void,
                  erro: @escaping (ErrorResponseEntity) -> Void,
                  completion: @escaping () -> Void
    )
    
    func searchMovie (query: String, language: LanguageType, success: @escaping ([MovieEntity]?) -> Void,
                      erro: @escaping (ErrorResponseEntity) -> Void,
                      completion: @escaping () -> Void
    )
    
    func categoryMovie (category: String, language: LanguageType, success: @escaping ([MovieEntity]?) -> Void,
                      erro: @escaping (ErrorResponseEntity) -> Void,
                      completion: @escaping () -> Void
    )
    
    func getDetail(id: Int, language: LanguageType, success: @escaping (DetailMovieEntity?) -> Void,
                   erro: @escaping (ErrorResponseEntity) -> Void,
                   completion: @escaping () -> Void
    )
    
    func getSimilar (id: Int, language: LanguageType, success: @escaping ([MovieEntity]?) -> Void,
                     erro: @escaping (ErrorResponseEntity) -> Void,
                     completion: @escaping () -> Void
    )
}

struct ApiUseCase: ApiUseCaseProtocol {
    func getMovie(success: @escaping ([MovieEntity]?) -> Void,
                  erro: @escaping (ErrorResponseEntity) -> Void,
                  completion: @escaping ()-> Void) {
        let baseUrl = Endpoints.shared.getTrendingMovie()
        if let data = apiRest(url: baseUrl) {
            success(data)
        }
        else {
            erro(ErrorResponseEntity.genericError)
        }
        completion()
    }
    
    func searchMovie(query: String, language: LanguageType,
                     success: @escaping ([MovieEntity]?) -> Void,
                     erro: @escaping (ErrorResponseEntity) -> Void,
                     completion: @escaping ()-> Void) {
        let baseUrl = Endpoints.shared.getSearchUrl(language: language.rawValue, query: query)
        if let data = apiRest(url: baseUrl) {
            success(data)
        }
        else {
            erro(ErrorResponseEntity.genericError)
        }
        completion()
    }
    
    func categoryMovie(category : String, language: LanguageType,
                       success: @escaping ([MovieEntity]?) -> Void, erro: @escaping (ErrorResponseEntity) -> Void,
                       completion: @escaping () -> Void) {
        let baseUrl = Endpoints.shared.getCategory(language: language.rawValue, category: category)
        if let data = apiRest(url: baseUrl) {
            success(data)
        }
        else {
            erro(ErrorResponseEntity.genericError)
        }
        completion()
    }
    
    func getDetail(id: Int, language: LanguageType, success: @escaping (DetailMovieEntity?) -> Void, erro: @escaping (ErrorResponseEntity) -> Void, completion: @escaping () -> Void) {
        let baseUrl = Endpoints.shared.getDetail(language: language.rawValue, id: id)
        if let url = URL(string: "\(baseUrl)"),
           let data = try? Data(contentsOf: url),
           let json = try? JSONDecoder().decode(DetailMovieEntity.self, from: data) {
            success(json)
        }
        else {
            erro(ErrorResponseEntity.genericError)
        }
        completion()
    }
    
    func getSimilar(id: Int, language: LanguageType, success: @escaping ([MovieEntity]?) -> Void, erro: @escaping (ErrorResponseEntity) -> Void, completion: @escaping () -> Void) {
        let baseUrl = Endpoints.shared.getSimilar(language: language.rawValue, id: id)
        if let data = apiRest(url: baseUrl) {
            success(data)
        }
        else {
            erro(ErrorResponseEntity.genericError)
        }
        completion()
    }
    
    func apiRest(url: String)-> [MovieEntity]? {
        if let url = URL(string: "\(url)"),
           let data = try? Data(contentsOf: url),
           let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
           let results = json.object(forKey: "results") as? [NSDictionary] {
            var movies: [MovieEntity] = []
            
            for result in results {
                if let id = result.object(forKey: "id") as? Int,
                   let title = result.object(forKey: "title") as? String,
                   let posterPath = result.object(forKey: "poster_path") as? String {
                    movies.append(MovieEntity(id: id, title: title, posterPath: posterPath))
                }
            }
           return movies
        } else {
            return nil
        }
    }
}