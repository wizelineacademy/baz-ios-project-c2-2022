//
//  SearchMoviesViewController.swift
//  BAZProject
//
//  Created by mvazquezl on 03/11/22.
//

import UIKit

class SearchMoviesViewController: UIViewController {

    @IBOutlet weak var srcBarMovies: UISearchBar!
    @IBOutlet weak var collectionResultMovies: UICollectionView!
    
    //MARK: Properties
    let movieAPI = MovieAPI()
    private var searchResults: [InfoMovies] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionResultMovies.reloadData()
            }
        }
    }
    
    //MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        instanceFromNib()
        setConfigSearchBar()
    }
    
    //MARK: private methods
    private func instanceFromNib() {
        collectionResultMovies.register(UINib(nibName: "MoreMoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MoreMoviesCollectionViewCell")
    }
    
    private func setConfigSearchBar() {
        self.srcBarMovies.delegate = self
        self.srcBarMovies.placeholder = "Encuentra tu película"
    }
    
    private func getResultsMovies(searchWord: String) {
        self.movieAPI.getMoviesSearched(wordToSearch: searchWord) { result in
            switch result {
            case .success(let movies):
                self.searchResults = movies
            case .failure(let error):
                debugPrint("Error\(error)")
                self.basicAlert(title: "Hubo algún problema", message: "\(error)")
            }
        }
    }
}

// MARK: - collectionView's DataSource

extension SearchMoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreMoviesCollectionViewCell", for: indexPath) as? MoreMoviesCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.showDetailsMovies(movie: searchResults[indexPath.row])
        return cell
    }
}

// MARK: - SearchBar Delegate

extension SearchMoviesViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchWord = searchBar.text {
            self.getResultsMovies(searchWord: searchWord)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.searchResults = []
        }
    }
}
