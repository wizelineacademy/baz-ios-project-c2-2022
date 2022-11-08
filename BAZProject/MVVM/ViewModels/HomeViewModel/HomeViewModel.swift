//
//  HomeViewModel.swift
//  BAZProject
//
//  Created by victor manzanero on 07/11/22.
//

import Foundation
import Bond

protocol HomeViewModelProtocol {
    func getMovies()
    func searchMovie(query: String, language: LanguageType)
    func getMoviesCategory(language: LanguageType)
    func getText(index: Int)-> String
    func getType(index: Int)
    var response: Observable<[MovieEntity]?> { get }
    var error: Observable<ErrorResponseEntity?> { get }
    var loading: Observable<typeLoading> { get }
    var search: Observable<[MovieEntity]?> { get }
    var category: Observable<MovieType?> { get }
    var title: Observable<String?> { get }
}

class HomeViewModel: HomeViewModelProtocol {
    
    private var usecase: ApiUseCaseProtocol?
    var response: Observable<[MovieEntity]?> = Observable(nil)
    var error: Observable<ErrorResponseEntity?> = Observable(nil)
    var loading: Observable<typeLoading> = Observable(.fullScreen)
    var search: Observable<[MovieEntity]?> = Observable(nil)
    var category: Observable<MovieType?> = Observable(nil)
    var title: Observable<String?> = Observable(nil)
    
    init(usecase: ApiUseCaseProtocol) {
        self.usecase = usecase
    }
    
    func getMovies() {
        self.usecase?.getMovie(success: { response in
            self.response.value = response
        }, erro: { error in
            self.error.value = error
        }, completion: {
            self.loading.value = .hide
        } )
    }
    
    func searchMovie(query: String, language: LanguageType = .es) {
        self.loading.value = .fullScreen
        self.usecase?.searchMovie(query: query, language: language, success: { response in
            if response?.count == 0 {
                self.error.value = ErrorResponseEntity(code: "001", message: staticLabel.noMovies)
            } else {
                self.response.value = response
            }
        }, erro: { error in
            self.error.value = error
        }, completion: {
            self.loading.value = .hide
        })
    }
    
    func getMoviesCategory(language: LanguageType = .es) {
        self.loading.value = .fullScreen
        self.usecase?.categoryMovie( category: self.category.value?.endPoint ?? "", language: language, success: { response in
            if response?.count == 0 {
                self.error.value = ErrorResponseEntity(code: "001", message: staticLabel.noMovies)
            } else {
                self.response.value = response
                self.title.value = self.category.value?.rawValue
            }
        }, erro: { error in
            self.error.value = error
        }, completion: {
            self.loading.value = .hide
        })
    }
    
    func getText(index: Int)-> String {
        switch index {
        case 1:
            return MovieType.trending.rawValue
        case 2:
            return MovieType.nowPlaying.rawValue
        case 3:
            return MovieType.popular.rawValue
        case 4:
            return MovieType.topRated.rawValue
        case 5:
            return MovieType.upcoming.rawValue
        default:
            return ""
        }
    }
    
    func getType(index: Int) {
        switch index {
        case 1:
            category.value = MovieType.trending
        case 2:
            category.value = MovieType.nowPlaying
        case 3:
            category.value = MovieType.popular
        case 4:
            category.value = MovieType.topRated
        case 5:
            category.value = MovieType.upcoming
        default:
            category.value = nil
        }
    }
}
