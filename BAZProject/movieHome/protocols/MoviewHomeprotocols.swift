//
//  MoviewHomeprotocols.swift
//  BAZProject
//
//  Created by 1028092 on 27/10/22.
//

import Foundation
protocol MoviewHomeViewToPresenterProtocol{
    var view: MovieHomePresenterToViewProtocol? {get set}
    var interactor: MovieHomePresenterToInteractorProtocol? {get set}
    var router: MovieHomePresenterToRouterProtocol? {get set}
    func getMoviesHomeData()
        
}
protocol MovieHomePresenterToViewProtocol{
    func getListMovies(listMovies: [Movie])
}
protocol MovieHomePresenterToRouterProtocol{
    
}
protocol MovieHomePresenterToInteractorProtocol{
    var presenter:MovieHomeInteractorToPresenterProtocol? {get set}
    func getMoviesInt()
}
protocol MovieHomeInteractorToPresenterProtocol{
    func resultMoviesList(movies: [Movie])
}
protocol MovieHomeDataExternalToInteractorProtocol{
    var movieAPI: MovieAPIProtocol? {get set}
    func responseListMovies(moviesList: [Movie])
}
protocol MovieAPIProtocol{
    var interactor: MovieHomeDataExternalToInteractorProtocol? {get set}
    func getMovies()
}

