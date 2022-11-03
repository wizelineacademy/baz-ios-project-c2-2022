//
//  MoviewHomeprotocols.swift
//  BAZProject
//
//  Created by 1028092 on 27/10/22.
//

import Foundation
import UIKit
protocol MoviewHomeViewToPresenterProtocol{
    var view: MovieHomePresenterToViewProtocol? {get set}
    var interactor: MovieHomePresenterToInteractorProtocol? {get set}
    var router: MovieHomePresenterToRouterProtocol? {get set}
    func getMoviesHomeData()
    func setUrlToImage(url: String) -> UIImage!
    
}
protocol MovieHomePresenterToViewProtocol{
    func getListMovies(listMovies: [Movie])
}
protocol MovieHomePresenterToRouterProtocol{
    static func createModule(view: TrendingViewController)
}
protocol MovieHomePresenterToInteractorProtocol{
    var presenter:MovieHomeInteractorToPresenterProtocol? {get set}
    func getMoviesInt()
    func setUrlToImage(url: String) -> UIImage!
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
protocol MovieAPIConstantsProtocol{
    var APIKEY: String { get }
    var APIMOVIELISTURL: String { get }
    var NAMEOBJECTRESPONSE: String { get }
    var URLIMAGE: String { get }
}

extension MovieAPIConstantsProtocol{
    var APIKEY: String { return "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"}
    
    var APIMOVIELISTURL: String { return "https://api.themoviedb.org/3/trending/movie/day?api_key=\(APIKEY)"}
    
    var NAMEOBJECTRESPONSE: String { return "results"}
    
    var URLIMAGE: String { return "https://image.tmdb.org/t/p/w500/"}
}

