//
//  MovieHomeTabBarRouter.swift
//  BAZProject
//
//  Created by 1028092 on 28/11/22.
//

import Foundation
import UIKit

final class MovieHomeTabBarRouter: MovieHomeTabBarRouterProtocol {
    
    /// This function not receive parameter
    /// - parameters
    /// initialize the module TabBar
    static func createModuleTabBar() -> UIViewController {
        let viewController: MovieHomeViewProtocol? = MovieHomeTabBarViewController()
        let presenter: MovieHomeTabBarPresenterProtocol = MovieHomeTabBarPresenter()
        let interactor: MovieHomeTabBarInteractorProtocol = MovieHomeTabBarinteractor()
        let router: MovieHomeTabBarRouterProtocol = MovieHomeTabBarRouter()
        
        viewController?.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        guard let view = viewController as? UIViewController else { return UIViewController()}
        
        return view
    }
    /// This function receive parameter viewController and UiTabNarController
    /// - parameters
    ///      - tabBar: set tabBar for the navigation
    ///      - viewController: get ViewController current
    func navigationTabBar(frame tabBar: UITabBarController, frame viewController: UIViewController) {
        viewController.navigationController?.pushViewController(tabBar, animated: true)
    }
    
    
}
