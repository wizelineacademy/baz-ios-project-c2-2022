//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UITableViewController {

    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let movieApi = MovieAPI()
        movies = movieApi.getMovies(endPoint: TrendingEndPoint())
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
        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(movies[indexPath.row].posterPath)") {
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
