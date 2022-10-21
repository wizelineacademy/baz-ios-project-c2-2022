//
//  DasboardViewController.swift
//  BAZProject
//
//

import UIKit

protocol MovieViewDelegate: NSObject {
    func showMovies()
}

protocol MovieFilterDelegate: NSObject {
    func getMoviesByCategory(category: CategoryMovieType)
}

class DasboardViewController: UIViewController {

    @IBOutlet var moviewTableView: UITableView!
    
    let moviePresenter = MoviePresenter(movieApiService: MovieAPI())
    private var filterController: FilterViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trending Movies"
        self.registerCell()
        self.moviePresenter.setMovieDelegate(movieViewDelegate: self)
        self.moviePresenter.getMoviesByCategory(category: .trending)
    }
    
    ///Register the custom cell that is used in the table
    private func registerCell(){
        self.moviewTableView.register(UINib(nibName: "MovieTableViewCell", bundle: Bundle(for: DasboardViewController.self)), forCellReuseIdentifier: "MovieTableViewCell" )
    }
    ///Show view controller in Modal Style to choose some category to show
    ///
    /// - Parameter sender: Contains a Button object
    @IBAction func showFilterAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Movies", bundle: Bundle(for: FilterViewController.self))
        self.filterController = storyboard.instantiateViewController(withIdentifier: "FilterViewController") as? FilterViewController ?? FilterViewController()
        self.filterController?.modalPresentationStyle = .formSheet
        self.filterController?.modalTransitionStyle = .coverVertical
        self.filterController?.filterDelegate = self
        self.navigationController?.present(self.filterController ?? FilterViewController(), animated: true, completion: nil)
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

// MARK: - Implement MovieViewDelegate
extension DasboardViewController: MovieFilterDelegate {
    func getMoviesByCategory(category: CategoryMovieType) {
        self.moviePresenter.getMoviesByCategory(category: category)
        self.title = "\(category.typeName) Movies"
    }
}
