//
//  TrendingViewController.swift
//  BAZProject
//
//  Created by 1028092 on 01/11/22.
//

import UIKit
class TrendingViewController: UITableViewController {
    var presenter: MoviewHomeViewToPresenterProtocol?

    var movies: [Movie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getMoviesHomeData()
        //let movieApi = MovieAPI()
        
        //movies = movieApi.getMovies()
        //tableView.reloadData()
    }
}

extension TrendingViewController: MovieHomePresenterToViewProtocol{
    func getListMovies(listMovies: [Movie]) {
        movies = listMovies
        self.tableView.reloadData()
    }
}
extension TrendingViewController{

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell")!
        }

}
// MARK: - TableView's DataSource
extension TrendingViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = movies[indexPath.row].title
        config.image = UIImage(named: "poster")
        cell.contentConfiguration = config
    }

}
