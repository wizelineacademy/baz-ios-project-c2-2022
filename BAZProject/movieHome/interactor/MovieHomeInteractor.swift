//
//  MovieHomeInteractor.swift
//  BAZProject
//
//  Created by 1028092 on 01/11/22.
//

import Foundation
import UIKit
final class MovieHomeInteractor: MovieHomePresenterToInteractorProtocol,  MovieHomeDataExternalToInteractorProtocol,MovieAPIConstantsProtocol{
    
    var movieAPI: MovieAPIProtocol?
    var presenter: MovieHomeInteractorToPresenterProtocol?
    ///This function does not receive parameters, call the service of movies
    func getMoviesInt(){
        self.movieAPI?.getMovies()
    }
    /// This  function receive how parameter a list of object movie
    /// - parameters
    ///     - movieList get the list of movies
    func responseListMovies(moviesList: [Movie]) {
        presenter?.resultMoviesList(movies: moviesList)
    }
    /// This function receive the url of image and retorn object UIImage
    /// - parameters
    ///     - url the url of image
    func setUrlToImage(url: String) -> UIImage!{
        if url.isEmpty{
            return UIImage(named: "poster")
        }
        if let url = URL(string: "\(String(describing: URLIMAGE))\(url)")
        {
            let data = try? Data(contentsOf: url)
            return UIImage(data: data!)
        }
        else{
            return UIImage(named: "poster")
        }
    }
}
