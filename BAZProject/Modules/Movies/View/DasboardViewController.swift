//
//  DasboardViewController.swift
//  BAZProject
//
//

import UIKit

protocol MovieViewDelegate: NSObjectProtocol {
    func showMovies()
}

class DasboardViewController: UIViewController {

    @IBOutlet var moviewTableView: UITableView!
    
    let moviePresenter = MoviePresenter(movieApiService: MovieAPI())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trending Movies"
        self.registerCell()
        self.moviePresenter.setMovieDelegate(movieViewDelegate: self)
        self.moviePresenter.getMovies()
    }
    
    ///Register the custom cell that is used in the table
    private func registerCell(){
        self.moviewTableView.register(UINib(nibName: "MovieTableViewCell", bundle: Bundle(for: DasboardViewController.self)), forCellReuseIdentifier: "MovieTableViewCell" )
    }
    
}

// MARK: - TableView's DataSource
extension DasboardViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moviePresenter.getTotalMovies()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = moviewTableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setUpMovie(movie: moviePresenter.getMovie(indexPath: indexPath.row),
                        baseUrl: moviePresenter.getUrlImgeMovie(indexPath: indexPath.row))
        cell.showMovie()
        return cell
    }
    
}

// MARK: - TableView's Delegate
extension DasboardViewController: UITableViewDelegate {

   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - Implement MovieViewDelegate
extension DasboardViewController: MovieViewDelegate {
    func showMovies() {
        if moviePresenter.getTotalMovies() > 0 {
            DispatchQueue.main.async {
                self.moviewTableView.reloadData()
            }
        }
    }
}
