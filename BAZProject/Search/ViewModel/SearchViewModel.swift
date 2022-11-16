//
//  SearchViewModel.swift
//  BAZProject
//
//  Created by Alan Emiliano Ramirez Ayala on 01/11/22.
//

import Foundation

final class SearchViewModel: PrincipalViewModel {
     
    var refreshData = { () -> () in }
    
    var dataArray: [Movie] = [] {
        didSet {
            refreshData()
        }
    }
    
    var movieApiDelegate: MovieApiDelegate?
    
    /// La funcion getInfo hace la peticion de la informacion con la instancia de la clase de MovieAPI y la guarda en el dataArray del ViewModel
    /// - Parameter api: El tipo de api que se busca la informacion
    func getInfo(_ api: MovieFeed) {
        self.dataArray = self.movieApiDelegate?.getMovies(api) ?? []
    }
    
}
