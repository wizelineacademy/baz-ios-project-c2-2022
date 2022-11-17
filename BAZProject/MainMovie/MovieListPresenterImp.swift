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

final class MainMoviePresenterImp: MainMoviePresenter {
    weak private var view: MainMovieView?
    private var mainMovieTabs: [MainMovieTab]
    
    init(interface: MainMovieView, mainMovieTabs: [MainMovieTab]) {
        self.view = interface
        self.mainMovieTabs = mainMovieTabs
    }
    
    func setTabs() {
        guard let mainMovieView = view as? MainMovieViewController else {
            return
        }
        mainMovieView.viewControllers = mainMovieTabs.map { $0.uiViewController }
        guard let viewControllers = mainMovieView.viewControllers else {
            return
        }
        for (index, controller) in viewControllers.enumerated() where index < mainMovieTabs.count {
            controller.tabBarItem.title = mainMovieTabs[index].tabBarTitle
            controller.tabBarItem.image = UIImage(systemName: mainMovieTabs[index].tabBarImages)
        }
    }
}

final class MovieListPresenterImp: MovieListPresenter {
    var interactor: MainMovieInteractor?
    private let router: MainMovieWireframeProtocol

    init(interactor: MainMovieInteractor?, router: MainMovieWireframeProtocol) {
        self.interactor = interactor
        self.router = router
    }

    func getMoviesService(page: Int?, endPointResult: @escaping (MovieResponseResult?) -> Void) {
        interactor?.getMoviesService(page: page, endPointResult: endPointResult)
    }
}
