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
    
    func setupView(with movie: DetailsMovieModel)
    
    func likeIconChange(with imagePath: String)
}

///Presenter to View, Presenter to Interactor and Presenter to Router
protocol DetailsMoviePresenterProtocols: AnyObject {
    var view: DetailsMovieViewProtocols? { get set }
    var router: DetailsMovieRouterProtocols? { get set }
    var interactor: DetailsMovieInteractorInputAndOutputProtocols? { get set }
    func setUpPresentToInteractor(with movie: Movie)
    func setUpPresenterToView(with movie: DetailsMovieModel)
    func likeButtonTapped(isLike: Bool, delegado: DetailsMovieDelegate)
    func changeIconLike(with imagePath: String)
}

protocol DetailsMovieRouterProtocols: AnyObject {
    static func createModuleDetailsMovie(with movie: Movie, and delegate: DetailsMovieDelegate, arrFavoriteMovies: [Int]) -> UIViewController
}

protocol DetailsMovieInteractorInputAndOutputProtocols: AnyObject {
    var arrFavoriteMovies: [Int]? { get set }
    var idMovie: Int? { get set }
    var presenter: DetailsMoviePresenterProtocols? { get set }
    var view: DetailsMovieViewProtocols? { get set }
    
    func setUpPresentToInteractor(with movie: Movie)
    func setupInteractorToPresent(with movie: DetailsMovieModel)
    
    func likeButtonTapped(isLike: Bool, delegado: DetailsMovieDelegate)
}
