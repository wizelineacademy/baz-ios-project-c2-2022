//
//  SearchMovieViewController.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 15/11/22.
//

import UIKit

class SearchMovieViewController: UIViewController {
    
    @IBOutlet weak var tableResultsSearchMovies: UITableView!
    @IBOutlet weak var txtSearchMovies: UISearchBar!
    
    var viewModel = SearchMovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
    }
    
    func configureView(){
        tableResultsSearchMovies.dataSource = self
        tableResultsSearchMovies.delegate = self
        txtSearchMovies.delegate = self
        tableResultsSearchMovies.register(SearchTableViewCell.nib(), forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
    
    private func bind(){
        viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async { 
                self?.tableResultsSearchMovies.reloadData()
            }
        }
    }
}

extension SearchMovieViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableResultsSearchMovies.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        let movie = viewModel.movies[indexPath.row]
        cell.lblTitleMovie.text = movie.title
        if let posterPath = movie.posterPath{
            cell.imgPosterPath.setMovieImage(nameImage: posterPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailMovieViewController") as! DetailMovieViewController
        detailViewController.movie = viewModel.movies[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension SearchMovieViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableResultsSearchMovies.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchMovie(query: txtSearchMovies.text ?? "")
        txtSearchMovies.resignFirstResponder()
       }
}
