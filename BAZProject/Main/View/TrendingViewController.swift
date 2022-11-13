//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UIViewController {
    
    @IBOutlet weak var tblMovie: UITableView! {
        didSet{
            tblMovie.delegate = self
            tblMovie.dataSource = self
            registerNibs()
        }
    }
    
    // MARK: - Properties
    let movieApi = MovieAPI()
    let identifier = "TrendingTableViewCell"
    var arrMovies : ResultsMovie?
    
    
    //MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        movieApi.delegado = self
        movieApi.getMovies()
    }
    
    /// Register the custom cell to Trending
    private func registerNibs() {
        tblMovie.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
}

//MARK: Delegado Movie
extension TrendingViewController: MovieDataDelegate{
    func showMovies(dataMovie: ResultsMovie) {
        arrMovies = dataMovie
        DispatchQueue.main.async {
            self.tblMovie.reloadData()
        }
    }
}

// MARK: - TableView's DataSource

extension TrendingViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMovies?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TrendingTableViewCell else{ return UITableViewCell() }
        if let dataMovie = arrMovies{
            let info = dataMovie.results[indexPath.row]
            cell.getInfoCell(movie: info )
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController(nibName: "DetailViewController",
                                      bundle: Bundle(for: DetailViewController.self))
        if let dataMovie = arrMovies{
            vc.dataMovie = dataMovie.results[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}



