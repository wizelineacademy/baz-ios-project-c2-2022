//
//  NowPlayingViewController.swift
//  BAZProject
//
//  Created by 1030364 on 18/10/22.
//

import UIKit

class NowPlayingViewController: UITableViewController {

    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let movieApi = MovieAPI()
        movies = movieApi.getMovies(endPoint: NowPlayingEndPoint())
        tableView.reloadData()
    }

}

// MARK: - TableView's DataSource

extension NowPlayingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "NowPlayingTableViewCell")!
    }

}

// MARK: - TableView's Delegate

extension NowPlayingViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = movies[indexPath.row].title
        config.image = UIImage(named: "poster")
        cell.contentConfiguration = config
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = MovieDetailRouter.createModule()
        self.present(detailView, animated: true, completion: nil)
    }

}
