//
//  MoviewHomeprotocols.swift
//  BAZProject
//
//  Created by 1028092 on 10/11/22.
//

import Foundation
import UIKit

protocol MoviewHomeViewToPresenterProtocol{
    var listMovies: [String:[Movie]] { get set }
    var setMoviesCategories: [String] { get set }
    var view: MovieHomePresenterToViewProtocol? { get set }
    var interactor: MovieHomePresenterToInteractorProtocol? { get set }
    var router: MovieHomePresenterToRouterProtocol? { get set }
    func callServiceApis(_ page: Int)
    func navigationToDetailMovie(at indexPath: IndexPath, listMovies: [Movie],from navigation: UIViewController)
    
}
protocol MovieHomePresenterToViewProtocol{
    func reloadMoviesTableView()
}
protocol MovieHomePresenterToRouterProtocol{
    static func createModule() -> UIViewController
    func navigationToMovieDetail(at indexPath: IndexPath, listMovies: [Movie],from navigation: UIViewController)
}
protocol MovieHomePresenterToInteractorProtocol{
    var presenter:MovieHomeInteractorToPresenterProtocol? {get set}
    func callAPIMovie(_ page: Int)
}
protocol MovieHomeInteractorToPresenterProtocol{
    var setMoviesCategories: [String] { get set }
    func resultApiMovies<T : Codable>(movies: [T],_ enumValues: String)
}

protocol MovieCollectionViewCellProtocol{
    var movieItem: String { get set }
}

protocol MovieCollectionSelectedProtocol: AnyObject{
    func didSelectMovie(at indexPath: IndexPath, listMovies: [Movie])
}

protocol MovieDetailDataViewControllerProtoco{
    func setDataMovie(movieData: Movie)
}
