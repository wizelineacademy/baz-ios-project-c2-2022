//
//  DetailsMovieModelAdapter.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 11/11/22.
//

import UIKit

extension Movie {
    
    func adaptToDetailsMovieModelAdapter(with listFavorites: [Int]) -> DetailsMovieModel {
        map(with: self, listFavorites: listFavorites)
    }
    
    private func map(with movie: Movie, listFavorites: [Int]) -> DetailsMovieModel {
        let isFavorite = listFavorites.contains(movie.id)
        let favoriteImage = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        let backdropPathImage = movie.backdropPath ?? "poster"
        return DetailsMovieModel(idMovie: movie.id, backgroundImage: backdropPathImage, titleMovie: movie.title, descriptionMovie: movie.overview, likedMovie: favoriteImage ?? UIImage())
    }
}
