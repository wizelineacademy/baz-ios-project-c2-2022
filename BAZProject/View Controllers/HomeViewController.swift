//
//  HomeViewController.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 08/11/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableMovies: UITableView!
    var viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
    }
    
    func configureView(){
        tableMovies.dataSource = self
        tableMovies.delegate = self
        tableMovies.register(MoviesCategoriesTableViewCell.nib(), forCellReuseIdentifier: MoviesCategoriesTableViewCell.identifier)
        viewModel.loadCategoriesMovies()
    }
    
    private func bind(){
        viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableMovies.reloadData()
            }
        }
    }

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate,MoviesCategoriesTableViewCellDelegate {
    func movieTapped(_ movie: Movie) {
        NotificationCenterHelper.notificacionCenter.post(name: Notification.Name(rawValue: "detailMovieCell.Notification"), object: nil, userInfo: ["detailMovie": movie])
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailMovieViewController") as! DetailMovieViewController
        detailViewController.movie = movie
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableMovies.dequeueReusableCell(withIdentifier: MoviesCategoriesTableViewCell.identifier, for: indexPath) as! MoviesCategoriesTableViewCell
        let category = viewModel.categories[indexPath.row]
        cell.lblNameCategory.text = category.nameCategory
        cell.configure(with: category.movies)
        cell.delegate = self
        return cell
    }
}
