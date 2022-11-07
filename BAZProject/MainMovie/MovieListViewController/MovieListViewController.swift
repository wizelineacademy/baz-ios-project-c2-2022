//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class MovieListViewController: UITableViewController, MainMovieViewProtocol {

    var presenter: MainMoviePresenterProtocol?
    private var movies: [MovieModel] = []
    var endPoint: EndPoint?
    var totalResults: Int = 0
    var totalPages: Int = 0
    private lazy var loaderMoreView: UIView = {
        let loaderView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        loaderView.color = UIColor.gray
        loaderView.startAnimating()
        return loaderView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MovieListTableViewCell.nib(), forCellReuseIdentifier: "MovieListTableViewCell")
        guard let endPoint = endPoint else {
            return
        }
        if let result = presenter?.getMovies(endPoint: endPoint) {
            movies = result.movies
            totalPages = result.totalPages
            totalResults = result.totalResults
        }
        tableView.reloadData()
    }

    func addData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            guard let endPoint = self.endPoint, let url = endPoint.url else {
                return
            }
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            self.movies += self.presenter?.getMovies(endPoint: endPoint).movies ?? []
            self.tableView.reloadData()
        }
    }

    func setUpLoaderView(toShow: Bool) {
        if toShow {
            self.tableView.tableFooterView?.isHidden = false
            self.tableView.tableFooterView = self.loaderMoreView
        } else {
            self.tableView.tableFooterView = UIView()
        }
    }
}

// MARK: - TableView's DataSource

extension MovieListViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as? MovieListTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(movie: movies[indexPath.row])
        return cell
    }

}

// MARK: - TableView's Delegate

extension MovieListViewController {

//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let currentCount = self.movies.count
//        if currentCount < totalResults && indexPath.row == (currentCount-1) {
//            self.addData()
//            self.setUpLoaderView(toShow: true)
//        } else {
//            self.setUpLoaderView(toShow: false)
//        }
//    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = MovieDetailRouter.createModule(movie: movies[indexPath.row])
        self.navigationController?.pushViewController(detailView, animated: true)
    }

}
