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
    @IBOutlet weak var collectionMovie: UICollectionView!{
        didSet{
            collectionMovie.delegate = self
            collectionMovie.dataSource = self
            registerNibs()
        }
    }
    
    let movieAPI = MovieAPI()
    private var searchResults: [Movie] = []
    var searchActive : Bool = false
    let identifier = "SearchCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBarMovie.delegate = self
        
    }
    
    private func registerNibs() {
        collectionMovie.register(UINib(nibName: "SearchCell", bundle: nil), forCellWithReuseIdentifier: "SearchCell")
    }
    
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = true
        if let searchWord = searchBar.text {
            self.getMoviesSearch(wordToSearch: searchWord)
        }
    }
    
}

extension Movie {
    func mapToViewData() -> SearchResultCellViewData {
        SearchResultCellViewData(title: self.title, posterPath: self.posterPath)
    }
}
