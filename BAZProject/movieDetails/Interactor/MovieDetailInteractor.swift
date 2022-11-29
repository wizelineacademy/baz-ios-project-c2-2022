//
//  MovieDetailInteractor.swift
//  BAZProject
//
//  Created by 1028092 on 20/11/22.
//

import Foundation
final class MovieDetailInteractor: MovieDetailInteractorProtocol,MovieHomeDataExternalToInteractorProtocol, MovieAPIConstantsProtocol {
    
    
    var movieAPI: MovieAPIProtocol?
    
    var presenter: MovieDetailPresenterProtocol?
    
    private lazy var setRecommendationsUrl: [Recommendations : String] = [Recommendations.recommendation:RECOMMENDATIONS, Recommendations.similar:SIMILAR]
    ///This function does not receive parameters, call the service of movies
    ///
    func callApiAll(_ page: Int, idMovie: String) {
        let _ : Movie? = self.movieAPI?.setMovies(urlCategoria: RECOMMENDATIONS.setUrlMoviePage(page).setMovieID(idMovie), Recommendations.recommendation.rawValue)
        let _ : Movie? = self.movieAPI?.setMovies(urlCategoria: SIMILAR.setUrlMoviePage(page).setMovieID(idMovie), Recommendations.similar.rawValue)
        let _ : Review? = self.movieAPI?.setMovies(urlCategoria: REVIEWS.setUrlMoviePage(page).setMovieID(idMovie), Recommendations.review.rawValue)
    }
    func responseListMovies<T>(dataMovie: Result<T>, _ enumValue: String){
        presenter?.resultApiMovies(list: dataMovie.results, enumValue)
    }
}
