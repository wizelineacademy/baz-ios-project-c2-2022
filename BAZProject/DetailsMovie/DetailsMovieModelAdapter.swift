//
//  DetailsMovieModelAdapter.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 11/11/22.
//

import UIKit

extension Movie {
    
    /// adaptToDetailsMovieModelAdapter: mapea Movie model to DetailsMovieModel
    ///  - Parameter listFavorites: Array movie id´s compare with movie id
    ///  - Returns: object type DetailsMovieModel
    func adaptToDetailsMovieModelAdapter(with listFavorites: [Int]) -> DetailsMovieModel {
        map(with: self, listFavorites: listFavorites)
    }
    
    /// map: mapea Movie model to DetailsMovieModel
    ///  - Parameter movie: object type Movie model
    ///  - Parameter listFavorites: Array movie id´s compare with movie id
    private func map(with movie: Movie, listFavorites: [Int]) -> DetailsMovieModel {
        let isFavorite = listFavorites.contains(movie.id)
        let favoriteImage = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        let backdropPathImage = movie.backdropPath ?? "poster"
        return DetailsMovieModel(idMovie: movie.id, backgroundImage: backdropPathImage, titleMovie: movie.title, descriptionMovie: movie.overview, likedMovie: favoriteImage ?? UIImage())
    }
}
