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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instanceFromNib()
        getMovies()
    }
    
    func instanceFromNib() {
        tblMovies.register(UINib(nibName: "ContentMoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentMoviesTableViewCell")
    }
    
    func getMovies() {
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
        let infoMovies = movies[indexPath.row]
        cell.showDetailsMovies(movie: infoMovies)
        let urlString = "https://image.tmdb.org/t/p/w500\(infoMovies.poster_path ?? "")"
            if let imageURL = URL(string: urlString) {
                DispatchQueue.global().async {
                    guard let imagenData = try? Data(contentsOf: imageURL)else {return}
                    let image = UIImage(data: imagenData)
                     DispatchQueue.main.async {
                        cell.imgMovies.image = image
                    }
                }
            }
        return cell
}
}

