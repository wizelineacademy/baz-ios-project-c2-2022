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
    var viewInterface: DetailsMovieViewController? { get }
}

///Presenter to View, Presenter to Interactor and Presenter to Router
protocol DetailsMoviePresenterProtocols: AnyObject {
    var view: DetailsMovieViewProtocols? { get set }
    var router: DetailsMovieRouterProtocols? { get set }
    var interactor: DetailsMovieInteractorInputAndOutputProtocols? { get set }
    
    func setUpPresentToInteractor()
    func btnLikedClick()
}

protocol DetailsMovieRouterProtocols: AnyObject {
    static func createModuleDetailsMovie(with movie: Movie, and delegate: DetailsMovieDelegate, liked: Bool) -> UIViewController
}

protocol DetailsMovieInteractorInputAndOutputProtocols: AnyObject {
    var presenter: DetailsMoviePresenterProtocols? { get set }
    var view: DetailsMovieViewProtocols? { get set }
    
    func setUpPresentToInteractor()
    func btnLikedClick()
}
