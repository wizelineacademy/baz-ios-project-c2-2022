//
//  TrendingViewsExtensions.swift
//  BAZProject
//
//  Created by 1028092 on 10/11/22.
//

import Foundation
import UIKit

extension TrendingViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
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
        let movieDetailViewController = MovieDetailViewController(movieDetailData: movies[indexPath.row])
        navigationController?.pushViewController(movieDetailViewController, animated: true)
        
        //detailViewController.setDataMovie(movieData: movies[indexPath.row])
        
    }
    
}

extension TrendingViewController: MovieHomePresenterToViewProtocol{
    func callApiListMovies(listMovies: [Movie]) {
        movies = listMovies
        collectionViewFlowLayout.reloadData()
    }
}


