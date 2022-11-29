//
//  HomeViewController.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 08/11/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var moviesTable: UITableView!
    var viewModel = HomeViewModel()
    var recentMovies: RecentMovies = RecentMovies()
    private var countRecentMovies: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
        notificationRecentMovies()
    }
    
    func configureView(){
        moviesTable.dataSource = self
        moviesTable.delegate = self
        moviesTable.register(MoviesCategoriesTableViewCell.nib(), forCellReuseIdentifier: MoviesCategoriesTableViewCell.identifier)
        viewModel.loadMoviesCategories()
    }
    
    private func bind(){
        viewModel.refreshData = { [weak moviesTable] () in
            DispatchQueue.main.async {
                moviesTable?.reloadData()
            }
        }
    }
    
    func notificationRecentMovies() {
        NotificationCenterHelper.subscribeToNotification(self, with: #selector(notificationReceived), name: Notification.Name(rawValue: "detailMovieCell.Notification"))
    }
    
    @objc func notificationReceived(_ notification: NSNotification) {
        guard let movie = notification.userInfo?["detailMovie"] as? Movie else {return}
        let duplicated = recentMovies.movies.contains { element in
            element.id == movie.id
        }
        if !duplicated {
            recentMovies.movies.append(movie)
            countRecentMovies+=1
            createBadge(countRecentMovies)
        }
    }
    
    func createBadge(_ counterMovies: Int){
        let tabBar = tabBarController!.tabBar
        let add = tabBar.items![2]
        add.badgeColor = counterMovies > 0 ? UIColor.red : UIColor.clear
        add.badgeValue = counterMovies > 0 ? "\(counterMovies)" : ""
    }


}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesTable.dequeueReusableCell(withIdentifier: MoviesCategoriesTableViewCell.identifier, for: indexPath) as! MoviesCategoriesTableViewCell
        let category = viewModel.categories[indexPath.row]
        cell.MovieCategoryNameLabel.text = category.nameCategory
        cell.configure(with: category.movies)
        cell.cellDelegate = self
        return cell
    }
}

extension HomeViewController: CollectionViewCellDelegate {
    func collectionView(_ movie: Movie) {
        NotificationCenterHelper.myNotificationCenter.post(name: Notification.Name(rawValue: "detailMovieCell.Notification"), object: nil, userInfo: ["detailMovie": movie])
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailsMovieViewController") as! DetailMovieViewController
        detailViewController.configureView(for: movie)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}


extension HomeViewController: RecentlyViewedMoviesDataSource {
    func badgeCleaned() {
        countRecentMovies = 0
    }
    
    func getListOfRecentMovies() -> RecentMovies {
        recentMovies
    }
}
