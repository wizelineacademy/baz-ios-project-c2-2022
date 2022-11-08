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
        movieApi.getMovies(by: .nowPlaying, completion: { resultado in
            switch resultado{
            case .success(let mov):
                self.movies = mov.movies
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error ):
                print("Error: \(error.localizedDescription)")
            }
        })
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
        let posterPath = movies[indexPath.row].posterPath ?? "poster"
        config.text = movies[indexPath.row].title
        config.image = movieApi.getImage(with: posterPath)
        cell.contentConfiguration = config
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MoviesCategoriesViewController()
        self.present(vc, animated: true)
    }

}
