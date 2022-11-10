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
    private var likeMovieIndex: Int = -1
    private let movieApi = SearchAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(moviesCount(_:)), name: .countMovieDetails, object: nil)
    }
    
    private func showMovieDetails(_ Element: Movie) {
        let vc = DetailsMovieRouter.createModuleDetailsMovie(with: Element, and: self)
        self.present(vc, animated: true)
    }
    
    @objc private func moviesCount(_ notification: Notification) {
        let countMovies = UserDefaults.standard.integer(forKey: "countMovies")
        print("Contador: \(countMovies)")
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
    func returnIdMovie(_ idMovie: Int) {
        self.likeMovieIndex = idMovie
        self.collectionView.reloadData()
    }
}


