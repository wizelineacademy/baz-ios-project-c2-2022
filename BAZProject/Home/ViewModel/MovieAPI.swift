//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class MovieAPI {

    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    /// Funcion getInformation obtiene la informacion de una api de peliculas dependiendo la URL que manden
    ///  - Parameter api: Seleccionas el tipo de api que solicitaras
    func getInformation(_ api: ApiURL,_ extra: String = "") -> [MovieResults] {
        let semaphore = DispatchSemaphore (value: 0)
        var url: String = ""
        switch api {
        case .Trendig, .NowPlaying, .Popular, .TopRated, .UpComing:
            url = "https://api.themoviedb.org/3\(api.url)?api_key=\(apiKey)"
        case .Keyword:
            url = "https://api.themoviedb.org/3\(api.url)?api_key=\(apiKey)&query=\(extra)"
        case .Search:
            url = "https://api.themoviedb.org/3\(api.url)?api_key=\(apiKey)&query=\(extra)"
        case .Reviews, .Similar, .Recommendations:
            url = "https://api.themoviedb.org/3\(api.url)?api_key=\(apiKey)"
            url = url.replacingOccurrences(of: "{movieID}", with: "\(extra)", options: .literal, range: nil)
        }
        let URL = URL(string: url)
        var request = URLRequest(url: URL! ,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        var infoJson: [MovieResults] = []
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let decoder = JSONDecoder()
            if let data = data {
                do {
                    let json = try decoder.decode(MovieApiModel.self, from: data)
                    infoJson = json.results
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        return infoJson
    }
    /// Funcion getMovies Obtiene las peliculas y su informacion mas importante
    ///- Parameter api: Seleccionas el tipo de api que solicitaras
    func getMovies(_ api: ApiURL) -> [Movie] {
        let jsonInfo: [MovieResults] = self.getInformation(api)
        var movies: [Movie] = []
        for result in jsonInfo {
            if let id = result.id,
               let title = result.title,
               let poster_path = result.poster_path {
                movies.append(Movie(id: id, title: title, poster_path: poster_path))}
        }
        return movies
    }

}
