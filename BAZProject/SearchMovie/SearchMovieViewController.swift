//
//  SearchMovieViewController.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 01/11/22.
//

import UIKit

final class SearchMovieViewController: UICollectionViewController, Storyboarded {
    
    private let itemsPerRow: CGFloat = 2.0
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private var movies: [Movie] = []
    private let movieApi = MovieAPI()
    private var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = self.createActivityIndicator()
    }
    
    private func showMovieDetails(_ Element: Movie) {
        let vc = DetailsMovieRouter.createModuleDetailsMovie(movie: Element)
        self.present(vc, animated: true)
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
        cell.setUpCell(movies[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showMovieDetails(movies[indexPath.row])
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
        activityIndicator = self.createActivityIndicator()
        activityIndicator.startAnimating()
        movieApi.searchMovie(with: text) { resultado in
            switch resultado {
            case .success(let result):
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)){
                    self.activityIndicator.stopAnimating()
                    self.movies = result.movies
                    if self.movies.isEmpty {
                        self.showError(with: .arrayEmpty)
                    }
                    self.collectionView.reloadData()
                    textField.text = nil
                    textField.resignFirstResponder()
                }
            case .failure(let error):
                self.activityIndicator.stopAnimating()
                DispatchQueue.main.async {
                    guard let error = error as? APIError else {return}
                    self.showError(with: error)
                }
            }
        }
        return true
    }
}


