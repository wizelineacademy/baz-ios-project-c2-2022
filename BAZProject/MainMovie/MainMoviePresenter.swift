//
//  MainMoviePresenter.swift
//  BAZProject
//
//  Created 1030364 on 18/10/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

final class MainMoviePresenter: MainMoviePresenterProtocol {

    weak private var view: MainMovieViewProtocol?
    var interactor: MainMovieInteractorProtocol?
    private let router: MainMovieWireframeProtocol

    init(interface: MainMovieViewProtocol, interactor: MainMovieInteractorProtocol?, router: MainMovieWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func getMovies(endPoint: EndPoint) -> MovieResponseResult {
        return interactor?.getMovies(endPoint: endPoint) ?? MovieResponseResult(totalPages: 0, totalResults: 0, movies: [])
    }

}