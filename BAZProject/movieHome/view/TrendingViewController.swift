//
//  TrendingViewController.swift
//  BAZProject
//
//  Created by 1028092 on 01/11/22.
//

import UIKit
final class TrendingViewController: UITableViewController {
    var presenter: MoviewHomeViewToPresenterProtocol?
    
    var movies: [Movie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieHomeRouter.createModule(view: self)
        
        presenter?.getMoviesHomeData()
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
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = movies[indexPath.row].title
        config.image = presenter?.setUrlToImage(url: movies[indexPath.row].backdrop)
        cell.contentConfiguration = config
    }
    
}
