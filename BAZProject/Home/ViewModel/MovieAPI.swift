//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class MovieAPI {

    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    /// Funcion getMovies obtiene la informacion de una api de peliculas dependiendo la URL que manden
    ///  - Parameter api: Seleccionas el tipo de api que solicitaras
//    func getMovies(_ api: ApiURL) -> [Movie] {
//        guard let url = URL(string: "https://api.themoviedb.org/3\(api.url)?api_key=\(apiKey)"),
//              let data = try? Data(contentsOf: url),
//              let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
//              let results = json.object(forKey: "results") as? [NSDictionary]
//        else {
//            return []
//        }
//        var movies: [Movie] = []
//
//        for result in results {
//            if let id = result.object(forKey: "id") as? Int,
//               let title = result.object(forKey: "title") as? String,
//               let poster_path = result.object(forKey: "poster_path") as? String {
//                movies.append(Movie(id: id, title: title, poster_path: poster_path))
//            }
//        }
//
//        return movies
//    }
    /// Funcion getMovies2 obtiene la informacion de una api de peliculas dependiendo la URL que manden
    ///  - Parameter api: Seleccionas el tipo de api que solicitaras
    func getInformation(_ api: ApiURL) -> [MovieResults] {
        let semaphore = DispatchSemaphore (value: 0)
        
        var request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es&region=MX&page=1")!,timeoutInterval: Double.infinity)
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
    func getMovies(_ api: ApiURL) -> [Movie] {
        let jsonInfo: [MovieResults] = self.getInformation(api)
        var movies: [Movie] = []
        for result in jsonInfo {
            if let id = result.id as? Int,
               let title = result.title as? String,
               let poster_path = result.poster_path as? String {
                movies.append(Movie(id: id, title: title, poster_path: poster_path))
            }
        }
        return movies
    }

}
