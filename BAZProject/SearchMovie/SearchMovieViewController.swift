//
//  SearchMovieViewController.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 01/11/22.
//

import UIKit

final class SearchMovieViewController: UICollectionViewController, Storyboarded{
    
    private let itemsPerRow: CGFloat = 2.0
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private var movies: [Movie] = []
    private var likeMovieIndex: [Int] = []
    private let movieApi = SearchAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(moviesCount(_:)), name: .countMovieDetails, object: nil)
    }
    /// showMovieDetails: present detail movie view
    /// - Parameter movie: object type Movie with movie info
    private func showMovieDetails(for movie: Movie) {
        let vc = DetailsMovieRouter.createModuleDetailsMovie(with: movie, and: self, arrFavoriteMovies: likeMovieIndex)
        self.present(vc, animated: true)
    }
    /// moviesCount:  get movie counts to userdefault
    /// - Parameter notification: object type Notification received data
    @objc private func moviesCount(_ notification: Notification) {
        let _ = UserDefaults.standard.integer(forKey: "countMovies")
    }
}

extension SearchMovieViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier, for: indexPath) as? MoviesCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setUpCell(movies[indexPath.row], self.likeMovieIndex)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showMovieDetails(for: movies[indexPath.row])
    }
}

extension SearchMovieViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem * 1.7)
    }
}

extension SearchMovieViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return true
        }
        view.endEditing(true)
        let indicatorAnimating = indicator
        indicatorAnimating.startAnimating()
        movieApi.searchMovie(with: text) { resultado in
            switch resultado {
            case .success(let result):
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)){
                    self.movies = result.movies
                    if self.movies.isEmpty {
                        self.showError(with: .arrayEmpty)
                    }
                    self.collectionView.reloadData()
                    textField.text = nil
                    textField.resignFirstResponder()
                    indicatorAnimating.stopAnimating()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    indicatorAnimating.stopAnimating()
                    guard let error = error as? APIError else {return}
                    self.showError(with: error)
                }
            }
        }
        return true
    }
}

extension SearchMovieViewController: DetailsMovieDelegate {
    /// addMovie: Add id into favoriteArrays
    /// - Parameter id: movie id´s
    func addMovie(with id: Int) {
        self.likeMovieIndex.append(id)
        self.collectionView.reloadData()
    }
    /// removeMovie: remove id into favoriteArrays
    /// - Parameter id: movie id´s
    func removeMovie(with id: Int) {
        self.likeMovieIndex = self.likeMovieIndex.filter { $0 != id}
        self.collectionView.reloadData()
    }
    
}


