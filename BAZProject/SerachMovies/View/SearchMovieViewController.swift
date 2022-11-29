//
//  SearchMovieViewController.swift
//  BAZProject
//
//  Created by 1028092 on 28/11/22.
//

import UIKit

final class SearchMovieViewController: UIViewController, UISearchBarDelegate,SearchMovieViewProtocol {
    var presenter: SearchMoviePresenterProtocol?
    var searchController: UISearchController?
    private var searchActivate: Bool = false
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "SearchMovieViewCell", bundle: nil), forCellReuseIdentifier: "SearchmovieViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchBar.delegate = self
        searchController?.obscuresBackgroundDuringPresentation = false
        searchController?.searchBar.placeholder = "Nombre de pelicula"
        tableView.tableHeaderView = searchController?.searchBar
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension SearchMovieViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let counts = presenter?.setResultMovies.count else { return 0}
        return counts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchmovieViewCell", for: indexPath) as? SearchMovieViewCell else { return .init() }
        
        guard let models = presenter?.setResultMovies[indexPath.row] else { return .init() }
        cell.imageCell.loadFromNetwork(models.posterPath)
        cell.titleLbl.text = models.title
        cell.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movies = presenter?.setResultMovies else { return }
        presenter?.didSelectMovie(at: indexPath, listMovies: movies, from: self)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            presenter?.callSearchMovies(1, idMovie: searchText.lowercased())
            searchActivate = true
        } else {
            presenter?.callSearchMovies(1, idMovie: searchText)
            searchActivate = false
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.callSearchMovies(1, idMovie: "")
        searchActivate = false
        tableView.reloadData()
    }
    
    
}
