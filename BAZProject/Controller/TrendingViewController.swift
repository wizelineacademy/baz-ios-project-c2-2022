//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UITableViewController {
    
    
    @IBOutlet var tblMovies: UITableView!
    
    //MARK: Properties
    let movieAPI = MovieAPI()
    var movies: [InfoMovies] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tblMovies.reloadData()
            }
        }
    }
    
    //MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        instanceFromNib()
        getMovies()
    }
    
    //MARK: private methods
    private func instanceFromNib() {
        tblMovies.register(UINib(nibName: "ContentMoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentMoviesTableViewCell")
    }
    
    private func getMovies() {
            self.movieAPI.getMovies { result in
                switch result {
                case .success(let movies):
                    self.movies = movies
                case .failure(let error):
                    debugPrint("Error\(error)")
                    self.basicAlert(title: "Hubo algún problema", message: "\(error)")
                }
        
            }
       
    }
}


// MARK: - TableView's DataSource

extension TrendingViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContentMoviesTableViewCell", for: indexPath) as? ContentMoviesTableViewCell else {
            return UITableViewCell()
        }
        cell.showDetailsMovies(movie: movies[indexPath.row])
        return cell
}
}

