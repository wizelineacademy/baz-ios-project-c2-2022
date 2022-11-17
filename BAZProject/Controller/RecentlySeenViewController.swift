//
//  RecentlySeenViewController.swift
//  BAZProject
//
//  Created by mvazquezl on 14/11/22.
//

import UIKit

/**Protocol
    - getRecentMovies: function to get recent movies and returns the RecentMovies class
    - badgeCleaned: function to reset the badge counter
 */
protocol RecentSeenDataSource: AnyObject {
    func getRecentMovies() -> RecentMovies
    func badgeCleaned()
}

class RecentlySeenTableViewController: UITableViewController {
    
    @IBOutlet weak var tblRecentlyMovies: UITableView!
    
    //MARK: Properties
    private var recentlyMovies: [InfoMovies] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tblRecentlyMovies.reloadData()
            }
        }
    }
    weak var delegateRecentMovies: RecentSeenDataSource?
    
    //MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        instanceFromNib()
        setDelegate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        resetBadge()
        recentlyMovies = delegateRecentMovies?.getRecentMovies().arrayMovies ?? []
    }
    
    //MARK: private methods
    private func instanceFromNib() {
        tblRecentlyMovies.register(UINib(nibName: "ContentMoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentMoviesTableViewCell")
    }
    
    private func resetBadge(){
        let tabBar = tabBarController!.tabBar
        let add = tabBar.items![2]
        add.badgeColor = UIColor.clear
        add.badgeValue = ""
        delegateRecentMovies?.badgeCleaned()
    }
    
    private func setDelegate() {
        delegateRecentMovies = (tabBarController?.viewControllers?.first as? UINavigationController)?.viewControllers.first as? TrendingViewController
    }
    
}

// MARK: - TableView's DataSource

extension RecentlySeenTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentlyMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContentMoviesTableViewCell", for: indexPath) as? ContentMoviesTableViewCell else {
            return UITableViewCell()
        }
        cell.showDetailsMovies(movie: recentlyMovies[indexPath.row])
        tblRecentlyMovies.separatorColor = .none
        return cell
    }
}
