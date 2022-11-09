//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UIViewController {
    
    @IBOutlet weak var tblMovie: UITableView!{
        didSet{
            tblMovie.delegate = self
            tblMovie.dataSource = self
            registerNibs()
        }
    }
    
    // MARK: - Properties
    let movieApi = MovieAPI()
    let identifier = "TrendingTableViewCell"
    
    //MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        movieApi.getMovies()
        movieApi.refreshData = { [weak self]() in
            DispatchQueue.main.async {
                self?.tblMovie.reloadData()
            }
        }
    }
    
    /// Register the custom cell to Trending
    private func registerNibs() {
        tblMovie.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
}

// MARK: - TableView's DataSource

extension TrendingViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieApi.dataMovie?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TrendingTableViewCell else{ return UITableViewCell() }
        if let dataMovie = movieApi.dataMovie{
            let info = dataMovie.results[indexPath.row]
            cell.getInfoCell(movie: info )
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController(nibName: "DetailViewController",
                                      bundle: Bundle(for: DetailViewController.self))
        if let dataMovie = movieApi.dataMovie{
            vc.dataMovie = dataMovie.results[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

