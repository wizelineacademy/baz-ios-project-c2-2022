//
//  MovieDetailProtocols.swift
//  BAZProject
//
//  Created by 1028092 on 23/11/22.
//

import Foundation
import UIKit
protocol MovieDetailViewProtocol: AnyObject {
    var presenter: MovieDetailPresenterInputProtocol? { get set }
    func reloadReviewsDetail()
    
}
protocol MovieDetailPresenterInputProtocol: AnyObject {
    var listMovies: [String:[Any]] { get set }
    var setMoviesRecommendations: [String] { get set }
    var view: MovieDetailViewProtocol? { get set }
    var interactor: MovieDetailInteractorProtocol? { get set }
    var router: MovieDetailRouterProtocol? { get set }
    func callServiceApis(_ page: Int,idMovie: String)
    func navigationToDetailMovie(at indexPath: IndexPath, listMovies: [Movie],from navigation: UIViewController)
    func generateListMovie(section: Int) -> [Any]
}
protocol MovieDetailPresenterProtocol: AnyObject {
    func resultApiMovies<T : Codable>(list: [T],_ enumValues: String)
}
protocol MovieDetailInteractorProtocol: AnyObject {
    var presenter: MovieDetailPresenterProtocol? { get set }
    func callApiAll(_ page: Int, idMovie: String)
}
protocol MovieDetailRouterProtocol: AnyObject {
    static func createModuleDetailView(at indexPath: IndexPath, listMovies: [Movie],from navigation: UIViewController)
    func navigationDetailMovieView(movie: Movie, from navigation: UIViewController)
}

protocol ReviewCollectionSelectedProtocol: AnyObject{
    func didSelectReview(at indexPath: IndexPath, listReviews: [Movie])
}
