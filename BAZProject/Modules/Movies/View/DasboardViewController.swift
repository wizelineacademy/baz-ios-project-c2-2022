//
//  DasboardViewController.swift
//  BAZProject
//
//

import UIKit
// swiftlint:disable class_delegate_protocol
protocol MovieViewDelegate: NSObject {
    func showMovies()
    func showResults()
}

protocol MovieFilterDelegate: NSObject {
    func getMoviesByCategory(category: CategoryMovieType)
}

class DasboardViewController: UIViewController {

    @IBOutlet weak var moviewTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultSearch: UICollectionView!
    private var filterController: MovieFilterViewController?
    private var searchResults: [Movie]?
    let moviePresenter = MoviePresenter(movieApiService: MovieAPI())
    // MARK: - Properties of collection configuration
    let numberOfSections = 1
    let insets: CGFloat = 8
    let heightAditionalConstant: CGFloat = 40
    let minimumLineSpacing: CGFloat = 10
    let minimumInteritemSpacing: CGFloat = 10
    let cellsPerRow: Int = 2
    // MARK: - Start
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("titleHome", comment: "title controller")
        self.registerCell()
        self.moviePresenter.setMovieDelegate(movieViewDelegate: self)
        self.moviePresenter.getMoviesByCategory(category: .trending)
        self.searchBar.delegate = self
        self.searchBar.placeholder = "Encuentra tu película"
        self.resultSearch.isHidden = true
    }
    /// Register the custom cell that is used in the table
    private func registerCell() {
        self.moviewTableView.register(UINib(nibName: "MovieTableViewCell",
                                            bundle: Bundle(for: DasboardViewController.self)),
                                      forCellReuseIdentifier: "MovieTableViewCell" )
        self.resultSearch.register(UINib(nibName: "MovieCollectionViewCell",
                                         bundle: Bundle(for: MovieCollectionViewCell.self)),
                                   forCellWithReuseIdentifier: "MovieCollectionViewCell")
    }
    /// Show view controller in Modal Style to choose some category to show
    ///
    /// - Parameter sender: Contains a Button object
    @IBAction func showFilterAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Movies", bundle: Bundle(for: MovieFilterViewController.self))
        self.filterController = storyboard.instantiateViewController(withIdentifier: "MovieFilterViewController")
        as? MovieFilterViewController ?? MovieFilterViewController()
        self.filterController?.modalPresentationStyle = .formSheet
        self.filterController?.modalTransitionStyle = .coverVertical
        self.filterController?.filterDelegate = self
        self.navigationController?.present(self.filterController ?? MovieFilterViewController(),
                                           animated: true,
                                           completion: nil)
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
        guard let cell = moviewTableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell",
                                                             for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.setUpMovie(movie: moviePresenter.getMovie(indexPath: indexPath.row, type: .table),
                        baseUrl: moviePresenter.getUrlImgeMovie(indexPath: indexPath.row, size: .small))
        cell.showMovie()
        return cell
    }
}

// MARK: - TableView's Delegate
extension DasboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = DetailMovieViewController(nibName: "DetailMovieViewController",
                                                         bundle: Bundle(for: DetailMovieViewController.self))
        if let movie = moviePresenter.getMovie(indexPath: indexPath.row, type: .table),
           let url = moviePresenter.getUrlImgeMovie(indexPath: indexPath.row, size: .big) {
            detailController.movie = movie
            detailController.urlImg = url
        }
        self.navigationController?.pushViewController(detailController, animated: true)
    }
}

// MARK: - Implement SearchBar
extension DasboardViewController: UISearchBarDelegate {
    /// Make a request to serach movie by any word or phrase
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchWord = searchBar.text {
            moviePresenter.getMoviesSearched(wordToSearch: searchWord)
            moviewTableView.isHidden = true
        }
    }
    /// Check the text box of the browser if it is clean hide the collection
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            moviewTableView.isHidden = false
        }
    }
}

// MARK: - Implement MovieViewDelegate
extension DasboardViewController: MovieViewDelegate {
    /// Show movies over table moviewTableView
    func showMovies() {
        if moviePresenter.getTotalMovies() > 0 {
            DispatchQueue.main.async {
                self.moviewTableView.reloadData()
                self.moviewTableView.isHidden = false
            }
        }
    }
    /// Show movies over collection resultSearch
    func showResults() {
        if moviePresenter.getSearchedMovies() > 0 {
            DispatchQueue.main.async {
                self.resultSearch.reloadData()
                self.resultSearch.isHidden = false
            }
        }
    }
}

// MARK: - Implement MovieViewDelegate
extension DasboardViewController: MovieFilterDelegate {
    ///  Make a Request to presenter to obtain movies by category
    func getMoviesByCategory(category: CategoryMovieType) {
        self.moviePresenter.getMoviesByCategory(category: category)
        self.title = "\(category.typeName) Movies"
    }
}
