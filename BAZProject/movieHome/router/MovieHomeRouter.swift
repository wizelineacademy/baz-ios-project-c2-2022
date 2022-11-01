//
//  MovieHomeRouter.swift
//  BAZProject
//
//  Created by 1028092 on 01/11/22.
//
import Foundation
import UIKit
class MovieHomeRouter: MovieHomePresenterToRouterProtocol{
    static func createModule() -> TrendingViewController{
        let view = mainstoryboard.instantiateViewController(withIdentifier: "TrendingViewController") as! TrendingViewController
                
        var presenter: MoviewHomeViewToPresenterProtocol & MovieHomeInteractorToPresenterProtocol = MovieHomePresenter()
        var interactor: MovieHomePresenterToInteractorProtocol & MovieHomeDataExternalToInteractorProtocol = MovieHomeInteractor()
        let router: MovieHomePresenterToRouterProtocol = MovieHomeRouter()
        var movieAPI: MovieAPIProtocol = MovieAPI()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.movieAPI = movieAPI
        movieAPI.interactor = interactor
        return view
    }
    static var mainstoryboard: UIStoryboard{
            return UIStoryboard(name:"Main",bundle: Bundle.main)
        }
        
        func pushToMovieScreen(navigationConroller navigationController:UINavigationController) {
            
            let movieModue = MovieHomeRouter.createModule()
            navigationController.pushViewController(movieModue,animated: true)
            
        }
}
