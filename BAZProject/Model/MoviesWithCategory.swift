//
//  MovieSection.swift
//  BAZProject
//
//  Created by VICTOR DIMAS MORENO on 03/11/22.
//

import Foundation

struct MoviesWithCategory {
    let genre: String
    let movies: [Movie]
    
    init(genre: String, movies: [Movie]) {
        self.genre = genre
        self.movies = movies
    }
}
