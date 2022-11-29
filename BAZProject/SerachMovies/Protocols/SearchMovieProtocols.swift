//
//  SearchMovieProtocols.swift
//  BAZProject
//
//  Created by 1028092 on 28/11/22.
//

import Foundation
import UIKit

protocol SearchMovieViewProtocol: AnyObject {
    var presenter: SearchMoviePresenterProtocol? { get set }
    func reloadTableView()
}

protocol SearchMoviePresenterProtocol: AnyObject {
    var interactor: SearchMovieInteractorProtocol? { get set }
    var router: SearchMovieRouterProtocol? { get set }
    var setResultMovies: [Movie] { get set }
    func callSearchMovies(_ page: Int, idMovie: String)
    func didSelectMovie(at indexPath: IndexPath, listMovies: [Movie], from navigation: UIViewController)
}
protocol SearchMoviePresenterOutPutProtocol: AnyObject {
    var view: SearchMovieViewProtocol? { get set }
    func resultApiMovies<T : Codable>(movies: [T])
}
protocol SearchMovieInteractorProtocol: AnyObject {
    var presenter: SearchMoviePresenterOutPutProtocol? { get set }
    func callApiAll(_ page: Int, idMovie: String)
}
protocol SearchMovieRouterProtocol: AnyObject {
    static func moduleInitSearch() -> UIViewController
    func navigationDetailMovie(at indexPath: IndexPath, listMovies: [Movie], from navigation: UIViewController)
}
