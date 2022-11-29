//
//  SearchMovieViewController.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 15/11/22.
//

import UIKit

class SearchMovieViewController: UIViewController {
    
    @IBOutlet weak var movieSearchResultsTable: UITableView!
    @IBOutlet weak var textToSearchBar: UISearchBar!
    
    var viewModel = SearchMovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
    }
    
    func configureView(){
        movieSearchResultsTable.dataSource = self
        movieSearchResultsTable.delegate = self
        textToSearchBar.delegate = self
        movieSearchResultsTable.register(SearchTableViewCell.nib(), forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
    
    private func bind(){
        viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async { 
                self?.movieSearchResultsTable.reloadData()
            }
        }
    }
}

extension SearchMovieViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieSearchResultsTable.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        let movie = viewModel.movies[indexPath.row]
        cell.movieTitleLabel.text = movie.title
        if let posterPath = movie.posterPath{
            cell.moviePosterImage.setMovieImage(nameImage: posterPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailsMovieViewController") as! DetailMovieViewController
        detailViewController.configureView(for: viewModel.movies[indexPath.row])
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension SearchMovieViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movieSearchResultsTable.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = textToSearchBar.text else { return }
        viewModel.searchMovie(with: query)
        textToSearchBar.resignFirstResponder()
    }
}
