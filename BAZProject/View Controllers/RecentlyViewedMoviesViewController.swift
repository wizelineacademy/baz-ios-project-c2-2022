//
//  RecentlyViewedMoviesViewController.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 29/11/22.
//

import UIKit

protocol RecentlyViewedMoviesDataSource: AnyObject {
    func getListOfRecentMovies() -> RecentMovies
    func badgeCleaned()
}

class RecentlyViewedMoviesViewController: UITableViewController {

    @IBOutlet weak var tableRecentMovies: UITableView!
    
    private var recentlyMovies: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableRecentMovies.reloadData()
            }
        }
    }
    
    weak var delegateRecentMovies: RecentlyViewedMoviesDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setDelegate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        resetBadge()
        recentlyMovies = delegateRecentMovies?.getListOfRecentMovies().movies ?? []
    }
    
    func configureView(){
        tableRecentMovies.dataSource = self
        tableRecentMovies.delegate = self
        tableRecentMovies.register(SearchTableViewCell.nib(), forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
    
    private func resetBadge(){
        let tabBar = tabBarController!.tabBar
        let add = tabBar.items![2]
        add.badgeColor = UIColor.clear
        add.badgeValue = ""
        delegateRecentMovies?.badgeCleaned()
    }
    
    private func setDelegate() {
        delegateRecentMovies = (tabBarController?.viewControllers?.first as? UINavigationController)?.viewControllers.first as? HomeViewController
       
    }
}

extension RecentlyViewedMoviesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentlyMovies.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableRecentMovies.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        let movie = recentlyMovies[indexPath.row]
        cell.movieTitleLabel.text = movie.title
        if let posterPath = movie.posterPath{
            cell.moviePosterImage.setMovieImage(nameImage: posterPath)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailsMovieViewController") as! DetailMovieViewController
        let movie = recentlyMovies[indexPath.row]
        detailViewController.configureView(for: movie)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
