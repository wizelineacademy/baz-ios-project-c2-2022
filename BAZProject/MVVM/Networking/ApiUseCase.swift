//
//  ApiUseCase.swift
//  BAZProject
//
//  Created by victor manzanero on 07/11/22.
//

import Foundation

protocol GetSimilarUseCase {
    func getSimilar (id: Int, language: String, success: @escaping ([MovieEntity]?) -> Void,
                     erro: @escaping (ErrorResponseEntity) -> Void,
                     completion: @escaping () -> Void
    )
}

protocol GetDetailUseCase {
    func getDetail(id: Int, language: String, success: @escaping (DetailMovieEntity?) -> Void,
                   erro: @escaping (ErrorResponseEntity) -> Void,
                   completion: @escaping () -> Void
    )
}
protocol SearchMovieUseCase {
    func searchMovie (query: String, language: LanguageType, success: @escaping ([MovieEntity]?) -> Void,
                      erro: @escaping (ErrorResponseEntity) -> Void,
                      completion: @escaping () -> Void
    )
}

protocol GetCategoryMovieUseCase {
    func categoryMovie (category: String, language: LanguageType, success: @escaping ([MovieEntity]?) -> Void,
                      erro: @escaping (ErrorResponseEntity) -> Void,
                      completion: @escaping () -> Void
    )
}

protocol GetMovieUseCase {
    func getMovie(success: @escaping ([MovieEntity]?) -> Void,
                  erro: @escaping (ErrorResponseEntity) -> Void,
                  completion: @escaping () -> Void
    )
}

protocol GetApiRest {
    func apiRest(url: String, success: @escaping ([MovieEntity]?) -> Void,
                 erro: @escaping () -> Void)
}

typealias ApiUseCaseProtocol = GetSimilarUseCase & GetDetailUseCase & SearchMovieUseCase & GetCategoryMovieUseCase & GetMovieUseCase & SearchMovieUseCase & GetApiRest

struct ApiUseCase: ApiUseCaseProtocol {
    func getMovie(success: @escaping ([MovieEntity]?) -> Void,
                  erro: @escaping (ErrorResponseEntity) -> Void,
                  completion: @escaping ()-> Void) {
        let baseUrl = Endpoints.shared.getTrendingMovie()
        apiRest(url: baseUrl, success: { data in
            success(data)
        }, erro: {
            erro(ErrorResponseEntity.genericError)
        })
        completion()
    }
    
    func searchMovie(query: String, language: LanguageType,
                     success: @escaping ([MovieEntity]?) -> Void,
                     erro: @escaping (ErrorResponseEntity) -> Void,
                     completion: @escaping ()-> Void) {
        let baseUrl = Endpoints.shared.getSearchUrl(language: language.rawValue, query: query)
        apiRest(url: baseUrl, success: { data in
            success(data)
        }, erro: {
            erro(ErrorResponseEntity.genericError)
        })
        completion()
    }
    
    func categoryMovie(category : String, language: LanguageType,
                       success: @escaping ([MovieEntity]?) -> Void, erro: @escaping (ErrorResponseEntity) -> Void,
                       completion: @escaping () -> Void) {
        let baseUrl = Endpoints.shared.getCategory(language: language.rawValue, category: category)
        apiRest(url: baseUrl, success: { data in
            success(data)
        }, erro: {
            erro(ErrorResponseEntity.genericError)
        })
        completion()
        
    }
    
    func getDetail(id: Int, language: String, success: @escaping (DetailMovieEntity?) -> Void, erro: @escaping (ErrorResponseEntity) -> Void, completion: @escaping () -> Void) {
        let baseUrl = Endpoints.shared.getDetail(language: language, id: id)
        guard let url = URL(string: baseUrl) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil {
                guard let data = data else { return }
                if let json = try? JSONDecoder().decode(DetailMovieEntity.self, from: data) {
                    success(json)
                } else {
                    erro(ErrorResponseEntity.genericError)
                }
            }
            completion()
        }.resume()
    }
    
    func getSimilar(id: Int, language: String, success: @escaping ([MovieEntity]?) -> Void, erro: @escaping (ErrorResponseEntity) -> Void, completion: @escaping () -> Void) {
        let baseUrl = Endpoints.shared.getSimilar(language: language, id: id)
        apiRest(url: baseUrl, success: { data in
            success(data)
        }, erro: {
            erro(ErrorResponseEntity.genericError)
        })
        completion()
    }
    
    func apiRest(url: String, success: @escaping ([MovieEntity]?) -> Void, erro: @escaping () -> Void) {
        guard let url = URL(string: url) else { return  }
        URLSession.shared.dataTask(with: url) { data, response,error  in
            guard let data = data else { return }
            if error == nil {
                if let result = try? JSONDecoder().decode(ResponseMovies.self, from: data) {
                    success(result.results)
                } else {
                    erro()
                }
            } else {
                erro()
            }
        }.resume()
    }
}
