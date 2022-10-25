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
        cell.contentConfiguration = config
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetails = detailsMovie(backgroundImage: movieApi.getImage(with: movies[indexPath.row].backdropPath), title: movies[indexPath.row].title, description: movies[indexPath.row].overview)
        let vc = DetailsMovieRouter.createModuleDetailsMovie(details: movieDetails)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }

}
