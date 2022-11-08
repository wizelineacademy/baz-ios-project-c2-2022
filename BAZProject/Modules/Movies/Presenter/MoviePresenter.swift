//
//  MoviePresenter.swift
//  BAZProject
//
//  Created by 1017143 on 17/10/22.
//

import Foundation

final class MoviePresenter {
    weak private var movieViewDelegate: MovieViewDelegate?
    private let movieApiService: MovieAPI
    private var movies: [Movie] =  []
    private var similarMovies: [Movie] =  []
    private var recomendedMovies: [Movie] =  []
    private var searchResultMovies: [Movie] =  []
    private var favorite = false
    // MARK: - Init of class
    init(movieApiService: MovieAPI) {
        self.movieApiService = movieApiService
    }
    /// Get the value of the delegate
    func setMovieDelegate(movieViewDelegate: MovieViewDelegate?) {
        self.movieViewDelegate = movieViewDelegate
    }
    /// Makes a query to the service, places the value in an array and calls a function of the view
    ///
    ///  - Parameter category: A value from enum with category name to build a request api
    func getMoviesByCategory(category: CategoryMovieType) {
        if category == .favorites {
            self.favorite = true
            self.movies = getMoviesSaved()
            self.movieViewDelegate?.showMovies()
        } else {
            movieApiService.getMovies(category: category.endpoint) { [weak self] movies in
                if let movies = movies {
                    self?.favorite = false
                    self?.movies = movies
                    self?.movieViewDelegate?.showMovies()
                }
            }
        }
    }
    /// Validate if section favorites is showing if is true refresh section
    func checkFavorites() {
        if favorite {
            getMoviesByCategory(category: .favorites)
        }
    }
    /// Makes a query to the service, places the value in an array and calls a function of the view
    ///
    /// - Parameter wordToSearch: String to search in request
    func getMoviesSearched(wordToSearch: String) {
        movieApiService.getMoviesSearched(wordToSearch: wordToSearch) { movies in
            if let movies = movies {
                self.searchResultMovies = movies
                self.movieViewDelegate?.showResults()
            }
        }
    }
    /// Get the number of movies included in the query
    ///
    /// - Returns: The number of movies
    func getTotalMovies() -> Int {
        return self.movies.count
    }
    /// Get the number of movies included in the query
    ///
    /// - Returns: The number of movies
    func getSearchedMovies() -> Int {
        return self.searchResultMovies.count
    }
    /// Get a movie object from an array of movies
    ///
    /// - Parameters:
    ///   - indexPath: Is the index of the array to query
    ///   - type: Identifier to choose a collection
    /// - Returns: The a Movie object
    func getMovie(indexPath: Int, type: CardType) -> Movie? {
        switch type {
        case .table:
            return self.movies[indexPath]
        case .collection:
            return self.searchResultMovies[indexPath]
        }
    }
    /// Validate is section showed is favorites
    ///
    /// - Returns: Propertie favorite indicating true or false
    func binIsHidden() -> Bool {
        return favorite
    }
    /// Get the url of the image
    ///
    /// - Parameters:
    ///   - indexPath: Is the index of the array the url of the image
    ///   - size: Identifier to choose the image size url
    /// - Returns: A string type url
    func getUrlImgeMovie(indexPath: Int, size: ImageType) -> String? {
        switch size {
        case .small:
            return self.movieApiService.getBaseUrlImg() + "\(movies[indexPath].posterPath ?? "")"
        case .middle:
            return self.movieApiService.getBaseUrlImg() + "\(searchResultMovies[indexPath].backdropPath ?? "")"
        case .big:
            return self.movieApiService.getBaseUrlImg() + "\(movies[indexPath].backdropPath ?? "")"
        }
    }
    /// Save one movie object in user Defaults
    ///
    /// - Parameter notification: instance to acceso to parameters of notification
    @objc func saveMovies(_ notification: NSNotification) {
        if let movie = notification.userInfo?["movie"] as? Movie {
        let encoder = JSONEncoder()
        var movies = getMoviesSaved()
        if movies.count > 0 {
            movies = movies.filter({$0.id != movie.id})
            movies.append(movie)
            if let encoded = try? encoder.encode(movies) {
                UserDefaults.standard.set(encoded, forKey: "MyFavoriteMovies")
            }
        } else {
            movies.append(movie)
            if let encoded = try? encoder.encode(movies) {
                UserDefaults.standard.set(encoded, forKey: "MyFavoriteMovies")
            }
        }}
    }
    /// Remove Movie Items saved in User Defaults
    ///
    /// - Parameter index: Indicate the index in the array to delete item
    func removeMovie(index: Int) {
        let encoder = JSONEncoder()
        var movies = getMoviesSaved()
        if !movies.isEmpty {
            movies.remove(at: index)
            if let encoded = try? encoder.encode(movies) {
                UserDefaults.standard.set(encoded, forKey: "MyFavoriteMovies")
                getMoviesByCategory(category: .favorites)
            }
        }
    }
    /// Retrive an array of movie objects from User Defaults
    ///
    /// - Returns: An array of mivie objects
    private func getMoviesSaved() -> [Movie] {
        let decoder = JSONDecoder()
        if let moviesData = UserDefaults.standard.object(forKey: "MyFavoriteMovies") as? Data,
           let moviesRetrived = try? decoder.decode([Movie].self, from: moviesData) {
            return moviesRetrived
        }
        return []
    }
    /// Create notification to save movie en User Defaults when user see deatil of it
    func startNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(saveMovies(_:)),
                                               name: NSNotification.Name("Movies.save"),
                                               object: nil)
    }
}
