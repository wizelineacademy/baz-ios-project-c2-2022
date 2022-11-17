//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

final class MovieListViewController: UITableViewController {

    enum TableSection: Int {
        case userList
        case loader
    }

    var presenter: MovieListPresenter?
    private var movies: [MovieModel] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    var endPoint: EndPoint?
    private let pageLimit = 20
    private var currentLastId: Int?
    private var currentPage: Int = 1
    private var moviesSelected: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadMovieTable(page: 1)
        configureNotificationCenter()
    }

    private func configureTableView() {
        tableView.register(MovieListTableViewCell.nib(), forCellReuseIdentifier: "MovieListTableViewCell")
    }

    private func loadMovieTable(page: Int) {
        presenter?.getMoviesService(page: page, endPointResult: { [weak self] resultEndPoint in
            if resultEndPoint != nil {
                if let result = resultEndPoint {
                    self?.movies.append(contentsOf: result.movies)
                    self?.currentLastId = result.movies.last?.movie.id
                }
            } else {
                return
            }
        })
    }
    
    private func configureNotificationCenter() {
        NotificationCenterHelper.subscribeToNotification(self, with: #selector(notificationReceived), name: NSNotification.Name(rawValue: "MovieListTable.TappedCell.Notification"))
    }
    
    @objc private func notificationReceived(_ notification: NSNotification) {
        guard let notification = notification.userInfo?["TappedMovie"] as? Bool else { return }
        if notification {
            moviesSelected += 1
            print(moviesSelected)
        }
    }
}

// MARK: - TableView's DataSource

extension MovieListViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let listSection = TableSection(rawValue: section) else { return 0 }
        switch listSection {
        case .userList:
            return movies.count
        case .loader:
            return movies.count >= pageLimit ? 1 : 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = TableSection(rawValue: indexPath.section) else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell",
                                                       for: indexPath) as? MovieListTableViewCell else {
            return UITableViewCell()
        }
        switch section {
        case .userList:
            cell.configureCell(movie: movies[indexPath.row])
        case .loader:
            cell.posterImage.image = nil
            cell.subtitle.text = ""
            cell.title.text = "Cargando..."
        }
        return cell
    }

}

// MARK: - TableView's Delegate

extension MovieListViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let section = TableSection(rawValue: indexPath.section) else { return }
        guard !movies.isEmpty else { return }
        if section == .loader {
            currentPage += currentPage
            loadMovieTable(page: currentPage)
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenterHelper.myNotificationCenter.post(name: NSNotification.Name(rawValue: "MovieListTable.TappedCell.Notification"), object: nil, userInfo: ["TappedMovie": true])
        let detailView = MovieDetailRouter.createModule(movie: movies[indexPath.row])
        self.navigationController?.pushViewController(detailView, animated: true)
    }

}
