//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class MovieAPI {

    func getMovies(endPoint: EndPoint) -> [Movie] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let url = endPoint.url
        let data = try? Data(contentsOf: url!)
        let movies = try? decoder.decode(GenericResponse.self, from: data!)
        guard let url = endPoint.url,
              let data = try? Data(contentsOf: url),
              let movies = try? decoder.decode(GenericResponse.self, from: data)
        else {
            return []
        }

        return movies.results
    }

}
