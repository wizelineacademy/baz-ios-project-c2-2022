//
//  ViewModelMovie.swift
//  BAZProject
//
//  Created by Alan Emiliano Ramirez Ayala on 19/10/22.
//

import Foundation
 
class ViewModelMovie: PrincipalViewModel {
    
    var refreshData = { () -> () in }
    
    var dicAllMovies: [String: [Movie]] = [:]
    
    var dataArray: [Movie] = [] {
        didSet {
            refreshData()
        }
    }
    var movieApiDelegate: MovieApiDelegate?
    /// La funcion getAllMovies obtiene la informacion de todas las peliculas dividadas y las guarda en un diccionario
    func getAllMovies() {
        dicAllMovies["Trending"] = self.movieApiDelegate?.getMovies(.Trendig)
        dicAllMovies["TopRated"] = self.movieApiDelegate?.getMovies(.TopRated)
        dicAllMovies["UpComing"] = self.movieApiDelegate?.getMovies(.UpComing)
        dicAllMovies["Popular"] = self.movieApiDelegate?.getMovies(.Popular)
        dicAllMovies["NowPlaying"] = self.movieApiDelegate?.getMovies(.NowPlaying)
        self.dataArray = dicAllMovies["Trending"] ?? []
    }
    /// La funcion getInfo hace la peticion de la informacion con la instancia de la clase de MovieAPI y la guarda en el dataArray del ViewModel
    /// - Parameter api: El tipo de api que se busca la informacion
    func getInfo(_ api: MovieFeed) {
        self.dataArray = self.movieApiDelegate?.getMovies(api) ?? []
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
    /// La funcion cambia la informacion a mostrar en el HomeView
    /// - Parameter index: Index de la informacion a mostrar en la tabla
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
