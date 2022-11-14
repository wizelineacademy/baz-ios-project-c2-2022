//
//  SearchViewController.swift
//  BAZProject
//
//  Created by Mayra Brenda Carreño Mondragon on 04/11/22.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBarMovie: UISearchBar!
    @IBOutlet weak var collectionMovie: UICollectionView! {
        didSet{
            collectionMovie.delegate = self
            collectionMovie.dataSource = self
            registerNibs()
        }
    }
    // MARK: - Properties
    let movieAPI = MovieAPI()
    private var searchResults: [Movie] = []
    var searchActive : Bool = false
    let identifier = "SearchCell"
    
    //MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBarMovie.delegate = self
    }
    
    /// Register the custom cell to Search
    private func registerNibs() {
        collectionMovie.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    /// Makes a query to the service
    ///  - Parameter :
    ///  - wordToSearch:   String to search in request
    private func getMoviesSearch(wordToSearch: String) {
        movieAPI.getMoviesSearch(wordToSearch: wordToSearch) { [weak self] movies in
            if let movies = movies {
                self?.searchResults = movies
                DispatchQueue.main.async {
                    self?.collectionMovie.reloadData()
                }
            }
        }
    }
}
// MARK: - CollectionView Delegate
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier , for: indexPath) as? SearchCell else {
            return UICollectionViewCell()
        }
        cell.getInfoCollection(movie: searchResults[indexPath.row].mapToViewData())
        return cell
    }
}

// MARK: - Implement SearchBar
extension SearchViewController : UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        searchActive = true
        DispatchQueue.main.async {
            if let searchWord = searchBar.text {
                self.getMoviesSearch(wordToSearch: searchWord)
            }
        }
    }
    
}

extension Movie {
    func mapToViewData() -> SearchResultCellViewData {
        SearchResultCellViewData(title: self.title, posterPath: self.posterPath)
    }
}
