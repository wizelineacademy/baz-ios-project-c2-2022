//
//  MovieHomeInteractor.swift
//  BAZProject
//
//  Created by 1028092 on 01/11/22.
//

import Foundation
class MovieHomeInteractor: MovieHomePresenterToInteractorProtocol,  MovieHomeDataExternalToInteractorProtocol{
    
    var movieAPI: MovieAPIProtocol?
    var presenter: MovieHomeInteractorToPresenterProtocol?
    //[]
    func getMoviesInt(){
        self.movieAPI?.getMovies()
    }
    func responseListMovies(moviesList: [Movie]) {
        presenter?.resultMoviesList(movies: moviesList)
    }
}
