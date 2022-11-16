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

final class DasboardViewController: UIViewController {

    @IBOutlet weak var moviewTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultSearch: UICollectionView!
    private var filterController: MovieFilterViewController?
    private var searchResults: [Movie]?
    private(set) var moviePresenter = MoviePresenter(movieApiService: MovieAPI())
    // MARK: - Start
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalizableKeys.Home.title
        self.registerCell()
        self.moviePresenter.setMovieDelegate(movieViewDelegate: self)
        self.moviePresenter.getMoviesByCategory(category: .trending)
        self.moviePresenter.startNotification()
        self.setConfigSearchBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.moviePresenter.checkFavorites()
        self.navigationItem.leftBarButtonItem?.title = self.moviePresenter.getMoviesVisited()
    }
    deinit {
        self.moviePresenter.stopNotification()
    }
    /// Config some properties of searchBar
    private func setConfigSearchBar() {
        self.searchBar.delegate = self
        self.searchBar.placeholder = LocalizableKeys.Home.placeHolder
        self.resultSearch.isHidden = true
    }
    /// Register customs cells that is used in the table
    private func registerCell() {
        self.moviewTableView.register(UINib(nibName: LocalizableKeys.Home.cell,
                                            bundle: Bundle(for: DasboardViewController.self)),
                                      forCellReuseIdentifier: LocalizableKeys.Home.cell )
        self.resultSearch.register(UINib(nibName: LocalizableKeys.Home.collection,
                                         bundle: Bundle(for: MovieCollectionViewCell.self)),
                                   forCellWithReuseIdentifier: LocalizableKeys.Home.collection)
    }
    /// Show view controller in Modal Style to choose some category to show
    ///
    /// - Parameter sender: Contains a Button object
    @IBAction func showFilterAction(_ sender: Any) {
        self.filterController = MovieFilterViewController.getViewController()
        self.filterController?.modalPresentationStyle = .formSheet
        self.filterController?.modalTransitionStyle = .coverVertical
        self.filterController?.filterDelegate = self
        self.navigationController?.present(self.filterController ?? MovieFilterViewController(),
                                           animated: true,
                                           completion: nil)
    }
    /// This show te movies visited
    @IBAction func showMoviesVisitedBtn() {
        self.moviePresenter.showVisitedMovies()
        self.title = LocalizableKeys.Home.titleVisited
    }
    /// Add action to Trash button showed in cell when the category is Favorites
    ///
    /// - Parameter sender: Contains a Button object
    @objc func removeMovie(sender: UIButton) {
        self.moviePresenter.removeMovie(index: sender.tag)
        self.navigationItem.leftBarButtonItem?.title = self.moviePresenter.getMoviesVisited()
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
        guard let cell = moviewTableView.dequeueReusableCell(withIdentifier: LocalizableKeys.Home.cell,
                                                             for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.trashBtn.tag = indexPath.row
        cell.trashBtn.addTarget(self, action: #selector(removeMovie(sender:)), for: .touchUpInside)
        cell.setUpMovie(movie: moviePresenter.getMovie(indexPath: indexPath.row, type: .table),
                        baseUrl: moviePresenter.getUrlImgeMovie(indexPath: indexPath.row, size: .small),
                        showBin: moviePresenter.binIsHidden())
        cell.showMovie()
        return cell
    }
}

// MARK: - TableView's Delegate
extension DasboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = DetailMovieViewController.getViewController()
        if let movie = moviePresenter.getMovie(indexPath: indexPath.row, type: .table),
           let url = moviePresenter.getUrlImgeMovie(indexPath: indexPath.row, size: .big) {
            detailController.movie = movie
            detailController.urlImg = url
            NotificationCenter.default.post(name: NSNotification.Name("Movies.save"),
                                            object: nil, userInfo: ["movie": movie])
        }
        self.navigationController?.pushViewController(detailController, animated: true)
    }
}

// MARK: - Implement SearchBar
extension DasboardViewController: UISearchBarDelegate {
    /// Make a request to serach movie by any word or phrase
    ///
    /// - Parameter searchBar: Contain a object of type UISearchBar, this is used to acces a values of the textbox
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
            DispatchQueue.main.async {
                self.moviewTableView.reloadData()
                self.moviewTableView.isHidden = false
            }
    }
    /// Show movies over collection resultSearch
    func showResults() {
        DispatchQueue.main.async {
            self.resultSearch.reloadData()
            self.resultSearch.isHidden = false
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
