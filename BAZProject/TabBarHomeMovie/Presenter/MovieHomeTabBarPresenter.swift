//
//  MovieHomeTabBarPresenter.swift
//  BAZProject
//
//  Created by 1028092 on 28/11/22.
//

import Foundation
import UIKit

final class MovieHomeTabBarPresenter: MovieHomeTabBarPresenterProtocol {
    
    var interactor: MovieHomeTabBarInteractorProtocol?
    
    var router: MovieHomeTabBarRouterProtocol?
    
    var setListViewsController: [UIViewController] = []
    
    /// This function receive parameter viewController
    /// - parameters
    ///      - viewController: set viewController for add the viewController Current
    func setViewsControllerBar(frame viewController: UIViewController) {
        interactor?.setAddControllers(frame: viewController)
    }
    
    /// This function receive parameter viewController and UiTabNarController
    /// - parameters
    ///      - tabBar: set tabBar for the navigation
    ///      - viewController: get ViewController current
    func showTabBar(frame viewController: UIViewController, frame tabBarController: UITabBarController) {
        router?.navigationTabBar(frame: tabBarController,frame: viewController)
    }
    
    
}
