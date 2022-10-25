//
//  ViewModelMovie.swift
//  BAZProject
//
//  Created by Alan Emiliano Ramirez Ayala on 19/10/22.
//

import Foundation

class ViewModelMovie {
    
    var refreshData = { () -> () in }
    
    var dicAllMovies: [String: [Movie]] = [:]
    
    var dataArray: [Movie] = [] {
        didSet {
            refreshData()
        }
    }
    /// La funcion getAllMovies obtiene la informacion de todas las peliculas dividadas y las guarda en un diccionario
    func getAllMovies() {
        dicAllMovies["Trending"] = self.movieApi.getMovies(.Trendig)
        dicAllMovies["TopRated"] = self.movieApi.getMovies(.TopRated)
        dicAllMovies["UpComing"] = self.movieApi.getMovies(.UpComing)
        dicAllMovies["Popular"] = self.movieApi.getMovies(.Popular)
        dicAllMovies["NowPlaying"] = self.movieApi.getMovies(.NowPlaying)
        self.dataArray = dicAllMovies["Trending"] ?? []
    }
    let movieApi = MovieAPI()
    /// La funcion getInfo hace la peticion de la informacion con la instancia de la clase de MovieAPI y la guarda en el dataArray del ViewModel
    /// - Parameter api: El tipo de api que se busca la informacion
    func getInfo(_ api: MovieFeed) {
        self.dataArray = self.movieApi.getMovies(api)
    }
    /// La funcion getInfoIndex devuelve la informacion de las peliculas del index que mandan
    /// - Parameter index: Index de la informacion que se busca.
    /// - Returns: Una estructura de tipo Movie
    func getInfoIndex(_ index: Int) -> Movie{
        return dataArray[index]
    }
    /// La funcion changeDataToShow actualiza la informacion del diccionario de dataArray
    /// - Parameter kindOfData: El tipo de peliculas que se busca actualizar
    func changeDataToShow(_ kindOfData: MovieFeed) {
        self.dataArray = dicAllMovies[kindOfData.name] ?? []
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
    
    func changeInfoByIndex(_ index: Int) {
        switch index {
        case 0:
            self.changeDataToShow(.Trendig)
        case 1:
            self.changeDataToShow(.NowPlaying)
        case 2:
            self.changeDataToShow(.Popular)
        case 3:
            self.changeDataToShow(.TopRated)
        default:
            self.changeDataToShow(.UpComing)
            
        }
    }
}
