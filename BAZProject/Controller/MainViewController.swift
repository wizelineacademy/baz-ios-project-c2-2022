//
//  MainViewController.swift
//  BAZProject
//
//  Created by VICTOR DIMAS MORENO on 03/11/22.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchCollection: UICollectionView!
    
    // MARK: - Private vars
    
    private var movies: [MoviesWithCategory] = []
    private var searchMovies: [Movie] = []
    private var filteredSearchMovies: [Movie] = []
    
    let searchController = UISearchController()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchCollection.delegate = self
        searchCollection.dataSource = self
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        
        let api = MovieAPI()
        movies = api.getMovies()
        searchMovies = api.getSearchMovies()
        
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        searchCollection.register(UINib(nibName: "SearchCell", bundle: nil), forCellWithReuseIdentifier: "searchCell")
    }
    
    // MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies[section].movies.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return movies[section].genre
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.printData(movie: movies[indexPath.section].movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        resultViewController.movie = movies[indexPath.section].movies[indexPath.row]
        self.navigationController?.pushViewController(resultViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - CollectionView Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredSearchMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = searchCollection.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        cell.printData(movie: filteredSearchMovies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        resultViewController.movie = filteredSearchMovies[indexPath.row]
        self.navigationController?.pushViewController(resultViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - SearchBar Methods
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text.isEmpty {
            searchCollection.isHidden = true
            filteredSearchMovies = searchMovies
        } else {
            searchCollection.isHidden = false
            filteredSearchMovies = searchMovies.filter { $0.title.lowercased().contains(text.lowercased()) }
        }
        self.searchCollection.reloadData()
    }
}
