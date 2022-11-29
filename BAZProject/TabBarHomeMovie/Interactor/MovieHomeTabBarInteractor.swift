//
//  MovieHomeTabBarInteractor.swift
//  BAZProject
//
//  Created by 1028092 on 28/11/22.
//

import Foundation
import UIKit

class MovieHomeTabBarinteractor : MovieHomeTabBarInteractorProtocol {
    var presenter: MovieHomeTabBarPresenterProtocol?
    
    /// This function receive parameter ViewController
    /// - parameters
    ///      - viewController: set viewController position
    func setAddControllers(frame viewController: UIViewController) {
        let tabBar = UITabBarController()
        let movies = MovieHomeRouter.createModule()
        let searchMovie = SearchMovieRouter.moduleInitSearch()
        movies.title = "Peliculas"
        searchMovie.title = "Buscar"
        let setControllers = [movies,searchMovie]
        tabBar.setViewControllers(setControllers, animated: false)
        guard let items = tabBar.tabBar.items else { return }
        let images = ["film","magnifyingglass"]
        
        for img in 0..<images.count {
            items[img].image = UIImage(systemName: images[img])
        }
        
        presenter?.showTabBar(frame: viewController, frame: tabBar)
    }
}
