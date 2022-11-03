//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class MovieAPI: MovieApiDelegate {
    let httpMeth = "GET"
    /// Funcion getInformation obtiene la informacion de una api de peliculas dependiendo la URL que manden
    ///  - Parameter api: Seleccionas el tipo de api que solicitaras
    func getInformation(_ api: MovieFeed) -> [MovieResults] {
        let semaphore = DispatchSemaphore (value: 0)
        var request = api.request
        request.httpMethod = httpMeth
        var infoJson: [MovieResults] = []
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                self.showError(.requestFailed)
                return
            }
            if httpResponse.statusCode == 200 {
                let decoder = JSONDecoder()
                if let data = data {
                    do {
                        let json = try decoder.decode(MovieApiModel.self, from: data)
                        infoJson = json.results
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
        let jsonInfo: [MovieResults] = self.getInformation(api)
        var movies: [Movie] = []
        for result in jsonInfo {
            if let id = result.id,
               let title = result.title,
               let posterPath = result.poster_path,
               let originalTitle = result.original_title,
               let voteAverage = result.vote_average,
               let overview = result.overview,
               let releaseDate = result.release_date,
               let backdropPath = result.backdrop_path{
                movies.append(Movie(id: id, title: title, posterPath: posterPath, originalTitle: originalTitle, voteAverage: voteAverage, overview: overview, releaseDate: releaseDate, backdropPath: backdropPath))}
        }
        return movies
    }
    /// Fucnon showError imprime un error
    /// - Parameter error: El tipo de error a imprimir
    func showError(_ error: APIError) {
        print("El error es: \(error)")
    }
    
    func getInfoBaseMovies(_ jsonInfo: [MovieResults]) -> [Movie] {
        var movies: [Movie] = []
        for result in jsonInfo {
            if let id = result.id,
               let title = result.title,
               let posterPath = result.poster_path,
               let originalTitle = result.original_title,
               let voteAverage = result.vote_average,
               let overview = result.overview,
               let releaseDate = result.release_date,
               let backdropPath = result.backdrop_path{
                movies.append(Movie(id: id, title: title, posterPath: posterPath, originalTitle: originalTitle, voteAverage: voteAverage, overview: overview, releaseDate: releaseDate, backdropPath: backdropPath))}
        }
        return movies
    }

}
