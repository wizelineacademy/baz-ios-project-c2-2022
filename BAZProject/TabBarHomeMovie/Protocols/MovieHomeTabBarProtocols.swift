//
//  MovieHomeTabBarProtocols.swift
//  BAZProject
//
//  Created by 1028092 on 28/11/22.
//

import Foundation
import UIKit

protocol MovieHomeViewProtocol: AnyObject {
    var presenter: MovieHomeTabBarPresenterProtocol? { get set }
}

protocol MovieHomeTabBarPresenterProtocol: AnyObject {
    var interactor: MovieHomeTabBarInteractorProtocol? { get set }
    var router: MovieHomeTabBarRouterProtocol? { get set }
    var setListViewsController: [UIViewController] { get set }
    func setViewsControllerBar(frame viewController: UIViewController)
    func showTabBar(frame viewController: UIViewController, frame tabBarController: UITabBarController)
}
protocol MovieHomeTabBarInteractorProtocol: AnyObject {
    var presenter: MovieHomeTabBarPresenterProtocol? { get set }
    func setAddControllers(frame viewController: UIViewController)
}
protocol MovieHomeTabBarRouterProtocol: AnyObject {
    func navigationTabBar(frame tabBar: UITabBarController, frame viewController: UIViewController)
}
