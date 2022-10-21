//
//  MainMovieViewController.swift
//  BAZProject
//
//  Created 1030364 on 18/10/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class MainMovieViewController: UITabBarController, MainMovieViewProtocol {

	var presenter: MainMoviePresenterProtocol?

    private let endPoints: [EndPoint] = [TrendingEndPoint(), NowPlayingEndPoint(), PopularEndPoint(), TopRatedEndPoint(), UpcomingEndPoint()]
    private let tabBarImages: [String] = ["chart.line.uptrend.xyaxis.circle.fill", "play.circle", "theatermasks", "star.fill", "arrowshape.turn.up.forward.circle"]
    private let tabBarTitles: [String] = ["Trending", "Now Playing", "Popular", "Top Rated", "Upcoming"]

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewControllers = self.viewControllers else {
            return
        }
        for (index, controller) in viewControllers.enumerated() {
            if let movieListViewController = controller as? MovieListViewController {
                movieListViewController.endPoint = endPoints[index]
                movieListViewController.tabBarItem.title = tabBarTitles[index]
                movieListViewController.tabBarItem.image = UIImage(systemName: tabBarImages[index])
            }
        }
    }

}
