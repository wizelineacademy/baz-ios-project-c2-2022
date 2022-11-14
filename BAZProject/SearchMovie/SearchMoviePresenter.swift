//
//  SearchMoviePresenter.swift
//  BAZProject
//
//  Created 1030364 on 17/10/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class SearchMoviePresenter: SearchMoviePresenterProtocol {

    weak private var view: SearchMovieViewProtocol?
    var interactor: SearchMovieInteractorProtocol?
    private let router: SearchMovieWireframeProtocol

    init(interface: SearchMovieViewProtocol, interactor: SearchMovieInteractorProtocol?, router: SearchMovieWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func getMovies(endPoint: EndPoint) -> MovieResponseResult {
        return interactor?.getMovies(endPoint: endPoint) ?? MovieResponseResult(totalPages: 0, totalResults: 0, movies: [])
    }
}