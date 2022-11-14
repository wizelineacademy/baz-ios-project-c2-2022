//
//  DetailsMovieProtocols.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 25/10/22.
//

import Foundation
import UIKit

///ViewToPresenter
protocol DetailsMovieViewProtocols: AnyObject {
    var presenter: DetailsMoviePresenterProtocols? { get set }
    func setupView(with movie: Movie, isFavorite: String)
    func likeIconChange(with imagePath: String)
    func setUpRecommendationMovies(with arrMovies: [Movie])
    func setUpSimilarMoview(with arrMovies: [Movie])
}

///Presenter to View, Presenter to Interactor and Presenter to Router
protocol DetailsMoviePresenterProtocols: AnyObject {
    var view: DetailsMovieViewProtocols? { get set }
    var router: DetailsMovieRouterProtocols? { get set }
    var interactor: DetailsMovieInteractorInputAndOutputProtocols? { get set }
    func setUpPresentToInteractor()
    func setUpPresenterToView(with movie: Movie, isFavorite: String)
    func likeButtonTapped(isLike: Bool, delegado: DetailsMovieDelegate)
    func changeIconLike(with imagePath: String)
    func setUpRecommendationMoviesToView(with arrMovies: [Movie])
    func setUpSimilarMoviewToView(with arrMovies: [Movie])
}

protocol DetailsMovieRouterProtocols: AnyObject {
    static func createModuleDetailsMovie(with movie: Movie, and delegate: DetailsMovieDelegate, arrFavoriteMovies: [Int]) -> UIViewController
}

protocol DetailsMovieInteractorInputAndOutputProtocols: AnyObject {
    var arrFavoriteMovies: [Int]? { get set }
    var idMovie: Int? { get set }
    var movie: Movie? { get set }
    var presenter: DetailsMoviePresenterProtocols? { get set }
    var view: DetailsMovieViewProtocols? { get set }
    
    func setUpPresentToInteractor()
    func setupInteractorToPresent(with movie: Movie, and isFavorite: String)
    func likeButtonTapped(isLike: Bool, delegado: DetailsMovieDelegate)
}
