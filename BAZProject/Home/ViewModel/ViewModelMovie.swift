//
//  ViewModelMovie.swift
//  BAZProject
//
//  Created by Alan Emiliano Ramirez Ayala on 19/10/22.
//

import Foundation

class ViewModelMovie {
    
    var refreshData = { () -> () in }
    
    var dataArray: [Movie] = [] {
        didSet {
            refreshData()
        }
    }
    let movieApi = MovieAPI()
    /// La funcion getInfo hace la peticion de la informacion con la instancia de la clase de MovieAPI y la guarda en el dataArray del ViewModel
    /// - Parameter api: El tipo de api que se busca la informacion
    func getInfo(_ api: MovieFeed) {
        self.dataArray = self.movieApi.getMovies(api)
    }
    
    /// La funcion getImage retorna la informacion de una imagen
    /// - Parameter urlImage: String con la url de la imagen a descargar
    /// - Returns: La infotmacion de la imagen descargada de tipo Data
    func getImage(urlImage: String) -> Data {
        let urlIm = "https://image.tmdb.org/t/p/w500\(urlImage)"
        guard let urlData = URL(string: urlIm),
              let data = try? Data(contentsOf: urlData) else { return Data() }
        return data
    }
}
