//
//  TrendingViewsExtensions.swift
//  BAZProject
//
//  Created by 1028092 on 09/11/22.
//

import Foundation
import UIKit
extension TrendingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identefier, for: indexPath) as? MovieListCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(model: movies[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailViewController = storyBoard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {
            return
        }
        
        detailViewController.setDataMovie(movieData: movies[indexPath.row])
        self.present(detailViewController, animated: true, completion: nil)
        
    }
}

extension TrendingViewController: MovieHomePresenterToViewProtocol{
    func callApiListMovies(listMovies: [Movie]) {
        movies = listMovies
        collectionViewFlowLayout.reloadData()
    }
}


