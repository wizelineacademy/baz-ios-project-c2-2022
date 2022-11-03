//
//  MovieHomePresenter.swift
//  BAZProject
//
//  Created by 1028092 on 01/11/22.
//

import Foundation
import UIKit
final class MovieHomePresenter: MoviewHomeViewToPresenterProtocol, MovieHomeInteractorToPresenterProtocol{
    var interactor: MovieHomePresenterToInteractorProtocol?
    
    var router: MovieHomePresenterToRouterProtocol?
    
    var view: MovieHomePresenterToViewProtocol?
    
    func getMoviesHomeData(){
        interactor?.getMoviesInt()
    }
    
    func resultMoviesList(movies: [Movie]) {
        self.view?.getListMovies(listMovies: movies)
    }
    func setUrlToImage(url: String) -> UIImage!{
        return interactor?.setUrlToImage(url: url)
    }
}
