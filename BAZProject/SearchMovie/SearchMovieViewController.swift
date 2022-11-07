//
//  SearchMovieViewController.swift
//  BAZProject
//
//  Created 1030364 on 17/10/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

final class SearchMovieViewController: UIViewController, SearchMovieViewProtocol {

	var presenter: SearchMoviePresenterProtocol?
    @IBOutlet weak var txtSearch: UISearchBar!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    private var movies: [MovieModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        txtSearch.delegate = self
    }

    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        movieCollectionView.collectionViewLayout = layout
        movieCollectionView.register(SearchMovieViewCell.nib(), forCellWithReuseIdentifier: "SearchMovieViewCell")
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
    }

    private func getMoviesToCollection(query: String) {
        if let results = presenter?.getMovies(endPoint: SearchEndPoint.init(query: query)) {
            movies = results.movies
        }
        movieCollectionView.reloadData()
    }
}

extension SearchMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchMovieViewCell", for: indexPath) as? SearchMovieViewCell else {
            return UICollectionViewCell()
        }
        if let poster = movies[indexPath.row].moviePoster {
            cell.configureCell(with: poster)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailView = MovieDetailRouter.createModule(movie: movies[indexPath.row])
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}

 extension SearchMovieViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        debugPrint(searchText)
        getMoviesToCollection(query: searchText)
    }

 }
