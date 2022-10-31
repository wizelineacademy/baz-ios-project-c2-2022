//
//  DetailsMovieProtocols.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 25/10/22.
//

import Foundation
import UIKit

///ViewToPresenter
protocol DetailsMovieViewProtocols: AnyObject {
    var presenter: DetailsMoviePresenterProtocols? { get set }
}

///Presenter to View, Presenter to Interactor and Presenter to Router
protocol DetailsMoviePresenterProtocols: AnyObject {
    var view: DetailsMovieViewProtocols? { get set }
    var router: DetailsMovieRouterProtocols? { get set }
    var interactor: DetailsMovieInteractorInputAndOutputProtocols? { get set }
}

protocol DetailsMovieRouterProtocols: AnyObject {
    static func createModuleDetailsMovie(movie: Movie) -> UIViewController
}

protocol DetailsMovieInteractorInputAndOutputProtocols: AnyObject {
    var presenter: DetailsMoviePresenterProtocols? { get set }
}
