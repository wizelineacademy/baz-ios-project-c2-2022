//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

final class TrendingViewController: UITableViewController {

    private var movies: [Movie] = []
    private let movieApi = MovieAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movies = movieApi.getMovies()
        tableView.reloadData()
    }

}

// MARK: - TableView's DataSource

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell")!
    }

}

// MARK: - TableView's Delegate

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = movies[indexPath.row].title
        config.image = movieApi.getImage(with: movies[indexPath.row].posterPath)
        print("ID movie: \(movies[indexPath.row].id)")
        cell.contentConfiguration = config
    }

}
