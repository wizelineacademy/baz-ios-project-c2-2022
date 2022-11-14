//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

final class MovieAPI: MovieApiDelegate {
    
    let httpMeth = "GET"
    
    /// Funcion getInformation obtiene la informacion de una api de peliculas dependiendo la URL que manden
    ///  - Parameter api: Seleccionas el tipo de api que solicitaras
    func getInformation(_ api: MovieFeed) -> [Any] {
        let semaphore = DispatchSemaphore (value: 0)
        var request = api.request
        request.httpMethod = httpMeth
        var infoJson: [Any] = []
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                self.showError(.requestFailed)
                return
            }
            if httpResponse.statusCode == 200 {
                let decoder = JSONDecoder()
                if let data = data {
                    do {
                        if api.name == "Credits" {
                            let json = try decoder.decode(CastApiModel.self, from: data)
                            infoJson = json.cast
                        } else {
                            let json = try decoder.decode(MovieApiModel.self, from: data)
                            infoJson = json.results
                        }
                    } catch {
                        self.showError(.jsonConversionFailure)
                    }
                } else {
                    self.showError(.invalidData)
                }
            } else {
                self.showError(.responseUnsuccessful)
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        return infoJson
    }
    /// Funcion getMovies Obtiene las peliculas y su informacion mas importante
    ///- Parameter api: Seleccionas el tipo de api que solicitaras
    func getMovies(_ api: MovieFeed) -> [Movie] {
        let movieInfo = self.getInformation(api) as! [MovieResults]
        var movies: [Movie] = []
        for result in movieInfo {
            let castInfo = self.getInformation(.Credits(movieID: result.id ?? 0)) as! [CastResults]
            if let id = result.id,
               let title = result.title,
               let posterPath = result.poster_path,
               let originalTitle = result.original_title,
               let voteAverage = result.vote_average,
               let overview = result.overview,
               let releaseDate = result.release_date,
               let backdropPath = result.backdrop_path {
                movies.append(Movie(id: id, title: title, posterPath: posterPath, originalTitle: originalTitle, voteAverage: voteAverage, overview: overview, releaseDate: releaseDate, backdropPath: backdropPath, cast: castInfo))}
        }
        return movies
    }
    /// Fucnon showError imprime un error
    /// - Parameter error: El tipo de error a imprimir
    func showError(_ error: APIError) {
        print("El error es: \(error)")
    }
    
}
