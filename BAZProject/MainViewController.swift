//
//  MainViewController.swift
//  BAZProject
//
//  Created by 1030364 on 19/10/22.
//

import UIKit

class MainViewController: UITabBarController {

    private let endPoints: [EndPoint] = [TrendingEndPoint(),
                                         NowPlayingEndPoint(),
                                         PopularEndPoint(),
                                         TopRatedEndPoint(),
                                         UpcomingEndPoint()]
    private let tabBarImages: [String] = ["chart.line.uptrend.xyaxis.circle.fill",
                                          "play.circle",
                                          "theatermasks",
                                          "star.fill",
                                          "arrowshape.turn.up.forward.circle"]
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
