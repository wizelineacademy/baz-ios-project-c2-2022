//
//  MovieAPI.swift
//  BAZProject
//
//  Created by 1028092 on 01/11/22.
//

import Foundation
class MovieAPI: MovieAPIProtocol {
    var interactor: MovieHomeDataExternalToInteractorProtocol?
    func getMovies() {
        guard let url = URL(string: APIMOVIELISTURL)
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
                do{
                    let getDeserialization = try JSONDecoder().decode(Result.self, from: datos)
                    DispatchQueue.main.async {
                        self.interactor?.responseListMovies(moviesList: getDeserialization.results)
                    }
                } catch let error{
                    print("Ho Ocurrido un error: \(error.localizedDescription)")
                }
            }
            else{
                
            }
        }.resume()
    }

}
