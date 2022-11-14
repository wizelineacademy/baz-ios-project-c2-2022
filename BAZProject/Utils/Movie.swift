//
//  Movie.swift
//  BAZProject
//
//

import Foundation
import UIKit

struct Movie: Decodable {
    let name: String?
    let id: Int?
    let title: String?
    let posterPath: String?
    let adult: Bool?
    let backdropPath: String?
    let genreIds: [Int]?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Float?
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let mediaType: String?
}

struct GenericResponse: Decodable {
    let dates: Dates?
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
}

struct Dates: Decodable {
    let maximum: String
    let minimum: String
}

struct MovieModel {
    let moviePoster: UIImage?
    let movieBackdrop: UIImage?
    let movie: Movie
}

struct MainMovieTab {
    var uiViewController: UIViewController
    var tabBarImages: String
    var tabBarTitle: String
}

struct MovieResponseResult {
    let totalPages: Int
    let totalResults: Int
    let movies: [MovieModel]
}
