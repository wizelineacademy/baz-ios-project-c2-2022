//
//  MovieAPI.swift
//  BAZProject
//
//  Created by 1028092 on 01/11/22.
//

import Foundation
final class MovieAPI: MovieAPIProtocol,MovieAPIConstantsProtocol {
    var interactor: MovieHomeDataExternalToInteractorProtocol?
    func getMovies() {
        guard let url = URL(string: self.APIMOVIELISTURL)
        else {
            return
        }
        
        URLSession.shared.dataTask(with: url){
            data,response,error in
            guard let datos = data, error == nil, let result = response as? HTTPURLResponse
            else{
                return
            }
            if result.statusCode == 200{
                guard let getDeserialization: Result = self.decode(data: datos) else { return }
                DispatchQueue.main.async {
                    self.interactor?.responseListMovies(moviesList: getDeserialization.results)
                }
            }
            else{
                
            }
        }.resume()
    }
    func decode<T:Decodable>(data: Data, jsonDecoder: JSONDecoder = JSONDecoder()) -> T?{
        return try? jsonDecoder.decode(T.self, from: data)
    }
    
}
