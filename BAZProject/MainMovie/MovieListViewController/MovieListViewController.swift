//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class MovieListViewController: UITableViewController {

    private var movies: [Movie] = []
    var endPoint: EndPoint?

    override func viewDidLoad() {
        super.viewDidLoad()
        let movieApi = MovieAPI()

        guard let endPoint = endPoint else {
            return
        }
        movies = movieApi.getMovies(endPoint: endPoint)
        tableView.reloadData()
    }

}

// MARK: - TableView's DataSource

extension MovieListViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell")!
    }

}

// MARK: - TableView's Delegate

extension MovieListViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = movies[indexPath.row].title ?? movies[indexPath.row].name
        let posterPath = movies[indexPath.row].posterPath ?? ""
        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            if let imageData = try? Data(contentsOf: url) {
                config.image = UIImage(data: imageData)
            } else {
                config.image = UIImage(named: "poster")
            }
        } else {
            config.image = UIImage(named: "poster")
        }
        cell.contentConfiguration = config
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = MovieDetailRouter.createModule()
        self.present(detailView, animated: true, completion: nil)
    }

}
