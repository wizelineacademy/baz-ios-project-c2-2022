//
//  Movie.swift
//  BAZProject
//
//

import Foundation

// MARK: - MovieSearch
struct MovieSearch: Codable {
    let results: [FoundMovies]
}

// MARK: - FoundMovies
struct FoundMovies: Codable {
    let name: String?
    let id: Int?
}

// MARK: - MovieDay
struct MovieDay: Codable {
    let results: [Movie]
}

// MARK: - Movie
struct Movie: Codable {
    let adult: Bool?
    let backdropPath: String?
    let id: Int?
    let title, originalLanguage, originalTitle, overview: String?
    let posterPath, mediaType: String?
    let genreIDS: [Int]?
    let popularity: Double?
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - ImageType
public enum ImageType {
    case small
    case middle
    case big
}

// MARK: - ImageType
public enum CardType {
    case table
    case collection
}

// MARK: - CategoryMovieType
public enum CategoryMovieType: String, CaseIterable {
    case trending
    case nowPlaying
    case popular
    case topRated
    case upcoming
    case favorites
    var endpoint: String {
        switch self {
        case .trending:
            return "url_trending".localized
        case .nowPlaying:
            return "url_now_playing".localized
        case .popular:
            return "url_popular".localized
        case .topRated:
            return "url_top_rated".localized
        case .upcoming:
            return "url_upcoming".localized
        case .favorites:
            return ""
        }
    }
    var typeName: String {
        switch self {
        case .trending:
            return "Trending"
        case .nowPlaying:
            return "Now Playing"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Upcoming"
        case .favorites:
            return "Favorites"
        }
    }
}
