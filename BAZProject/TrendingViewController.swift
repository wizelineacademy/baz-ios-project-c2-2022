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
                DispatchQueue.main.async {
                    guard let error = error as? APIError else {return}
                    self.showError(with: error)
                }
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell") else {
            return UITableViewCell()
        }
        var config = UIListContentConfiguration.cell()
        let posterPath = movies[indexPath.row].posterPath ?? "poster"
        config.text = movies[indexPath.row].title
        ImageAPI.getImage(with: posterPath) { result in
            switch result {
            case .success(let image):
                config.image = image
            case .failure(_):
                config.image = UIImage(named: "poster")
            }
        }
        cell.contentConfiguration = config
        return cell
    }

}

// MARK: - TableView's Delegate

extension TrendingViewController { 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MoviesCategoriesViewController()
        self.present(vc, animated: true)
    }

}
