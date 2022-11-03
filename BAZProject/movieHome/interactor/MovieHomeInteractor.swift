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
    func getMoviesInt(){
        self.movieAPI?.getMovies()
    }
    func responseListMovies(moviesList: [Movie]) {
        presenter?.resultMoviesList(movies: moviesList)
    }
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
