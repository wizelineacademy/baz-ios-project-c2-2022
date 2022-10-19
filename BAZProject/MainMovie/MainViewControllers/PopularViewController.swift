//
//  PopularViewController.swift
//  BAZProject
//
//  Created by 1030364 on 19/10/22.
//

import UIKit

class PopularViewController: UITableViewController {

    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let movieApi = MovieAPI()
        movies = movieApi.getMovies(endPoint: PopularEndPoint())
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "PopularTableViewCell")!
    }

    // MARK: - TableView's Delegate

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
