//
//  HomeViewController.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 08/11/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableMovies: UITableView!
    @IBOutlet weak var searchMovies: UISearchBar!
    
    var viewModel = ViewModelMovies()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()

    }
    
    func configureView(){
        tableMovies.dataSource = self
        tableMovies.delegate = self
        searchMovies.delegate = self
        tableMovies.register(MoviesCategoriesTableViewCell.nib(), forCellReuseIdentifier: MoviesCategoriesTableViewCell.identifier)
        viewModel.retriveMoviesList()
    }
    private func bind(){
        viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableMovies.reloadData()
            }
        }
    }

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableMovies.dequeueReusableCell(withIdentifier: MoviesCategoriesTableViewCell.identifier, for: indexPath) as! MoviesCategoriesTableViewCell
        cell.lblNameCategory.text = "Trending"
        cell.configure(with: viewModel.movies)
        return cell
    }
    
    
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableMovies.reloadData()
        }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchMovies(query: searchBar.text ?? "")
        searchMovies.resignFirstResponder()
    }

}
