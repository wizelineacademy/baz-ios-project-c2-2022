//
//  SearchMovieViewController.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 01/11/22.
//

import UIKit

final class SearchMovieViewController: UICollectionViewController {
    
    let reuseIdentifier = "movieCollection"
    let itemsPerRow: CGFloat = 2.0
    let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private var movies: [Movie] = []
    private let movieApi = MovieAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SearchMovieViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MoviesCollectionViewCell else {
            return UICollectionViewCell()
        }
        let posterPath = movies[indexPath.row].posterPath ?? "poster"
        cell.titleMovie.text = movies[indexPath.row].title
        cell.imageMovie.image = movieApi.getImage(with: posterPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailsMovieRouter.createModuleDetailsMovie(movie: movies[indexPath.row])
        self.present(vc, animated: true)
    }
    
    
}

extension SearchMovieViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension SearchMovieViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return true
        }
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        textField.addSubview(activityIndicator)
        activityIndicator.frame = textField.bounds
        activityIndicator.startAnimating()
        
        movies = movieApi.searchMovieByName(text)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)){
            activityIndicator.stopAnimating()
            self.collectionView.reloadData()
            textField.text = nil
            textField.resignFirstResponder()
        }
        return true
    }
}


