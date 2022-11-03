//
//  MovieHomeRouter.swift
//  BAZProject
//
//  Created by 1028092 on 01/11/22.
//
import Foundation
import UIKit
final class MovieHomeRouter: MovieHomePresenterToRouterProtocol{
    /// This function receive parameter viewController
    /// - parameters
    ///      - view: receive the view of viewController called
    static func createModule(view: TrendingViewController){
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
    }
}
