//
//  DetailMovieViewModel.swift
//  BAZProject
//
//  Created by victor manzanero on 09/11/22.
//

import Foundation
import Bond

protocol DetailMovieViewModelProtocol {
    func getDetail(id: Int)
    func getSimilar(id: Int)
    var response: Observable<DetailMovieEntity?> { get }
    var error: Observable<ErrorResponseEntity?> { get }
    var loading: Observable<TypeLoading> { get }
    var similar: Observable<[MovieEntity]?> { get }
}

final class DetailMovieViewModel: DetailMovieViewModelProtocol {
    private var usecase: ApiUseCaseProtocol?
    var response: Observable<DetailMovieEntity?> = Observable(nil)
    var error: Observable<ErrorResponseEntity?> = Observable(nil)
    var loading: Observable<TypeLoading> = Observable(.fullScreen)
    var similar: Observable<[MovieEntity]?> = Observable(nil)
    
    init(usecase: ApiUseCaseProtocol) {
        self.usecase = usecase
    }
    
    func getDetail(id: Int) {
        self.loading.value = .fullScreen
        self.usecase?.getDetail( id: id, language: .es, success: { response in
            self.response.value = response
        }, erro: { error in
            self.error.value = error
        }, completion: {
            self.loading.value = .hide
        })
    }
    
    func getSimilar(id: Int) {
        self.loading.value = .fullScreen
        self.usecase?.getSimilar( id: id, language: .es, success: { response in
            self.similar.value = response
        }, erro: { error in
            self.error.value = error
        }, completion: {
            self.loading.value = .hide
        })
    }
}
