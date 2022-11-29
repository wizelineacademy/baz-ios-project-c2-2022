//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

final class TrendingViewController: UITableViewController {
    
    var presenter: MoviewHomeViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        self.tabBarController?.navigationItem.hidesBackButton = true
        presenter?.callServiceApis(1)
        
    }
    
    /// This function dot not receive parameter setupTable
    /// - parameters
    private func setupTableView() {
        tableView.register(MoviesTableViewCell.nib(), forCellReuseIdentifier: MoviesTableViewCell.identifier)
        tableView.register(HeaderViewCell.nib(), forHeaderFooterViewReuseIdentifier: HeaderViewCell.identifier)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier, for: indexPath) as? MoviesTableViewCell else { return .init() }
        DispatchQueue.main.async {
            guard let getListMovies = self.presenter?.setMoviesCategories[indexPath.section], let movies = self.presenter?.listMovies.first(where: { $0.key == getListMovies})?.value else {
                return
            }
            cell.setup(movies: movies, delegate: self)
        }
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let count = presenter?.setMoviesCategories.count else {
            return 0
        }
        return count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240.0
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection
                            section: Int) -> String? {
        return presenter?.setMoviesCategories[section]
    }
}



extension TrendingViewController: MovieCollectionSelectedProtocol {
    /// This function receive parameter viewController
    /// - parameters
    ///      - indexPath: position of the array
    ///      - listMovies: array model Movie
    func didSelectMovie(at indexPath: IndexPath, listMovies: [Movie]) {
        presenter?.navigationToDetailMovie(at: indexPath, listMovies: listMovies, from: self)
    }
}

extension TrendingViewController: MovieHomePresenterToViewProtocol {
    /// This function dot not receive parameter reloadMoviesTableView
    /// - parameters
    func reloadMoviesTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
