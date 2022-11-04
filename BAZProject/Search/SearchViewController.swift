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
            registerNibs()
            self.collectionMovie.reloadData()
        }
    }
    
    let movieAPI = MovieAPI()
    private var searchResults: [Movie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBarMovie.delegate = self
    }
    
    private func registerNibs() {
        collectionMovie.register(UINib(nibName: "SearchCell", bundle: nil), forCellWithReuseIdentifier: "SearchCell")
    }
    
    private func getMoviesSearch(wordToSearch: String) {
        movieAPI.getMoviesSearch(wordToSearch: wordToSearch) { movies in
            if let movies = movies {
                self.searchResults = movies
            }
        }
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as? SearchCell else {
            return UICollectionViewCell()
        }
        cell.getInfoCollection(movie: searchResults[indexPath.row])
        return cell
    }
}

extension SearchViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchWord = searchBar.text {
            self.getMoviesSearch(wordToSearch: searchWord)
            
        }
    }
}


