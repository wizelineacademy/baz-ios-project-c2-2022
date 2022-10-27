//
//  DetailMovieViewControllerExtRecomended.swift
//  BAZProject
//
//  Created by 1017143 on 24/10/22.
//

import Foundation
import UIKit

extension DetailMovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return getMoviesForCollection(nameCollection: collectionView)
    }
    // swiftlint:disable:next line_length
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionType = getCollectionType(nameCollection: collectionView)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell",
                                                            for: indexPath as IndexPath) as? MovieCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        switch collectionType {
        case .similar:
            cell.createCardMovie(movie: similarMovie[indexPath.row],
                                 url: movieDetailPresenter.getUrlImgeMovie(indexPath: indexPath.row,
                                                                           section: .similar,
                                                                           size: .small) ?? "")
        case .recommended:
            cell.createCardMovie(movie: recomendedMovie[indexPath.row],
                                 url: movieDetailPresenter.getUrlImgeMovie(indexPath: indexPath.row,
                                                                           section: .recommended,
                                                                           size: .small) ?? "")
        }
        return cell
    }
}

extension DetailMovieViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = DetailMovieViewController(nibName: "DetailMovieViewController",
                                                         bundle: Bundle(for: DetailMovieViewController.self))
        let collectionType = getCollectionType(nameCollection: collectionView)
        if let movie = movieDetailPresenter.getMovie(indexPath: indexPath.row, section: collectionType),
           let url = movieDetailPresenter.getUrlImgeMovie(indexPath: indexPath.row,
                                                          section: collectionType,
                                                          size: .big) {
            detailController.movie = movie
            detailController.urlImg = url
        }
        self.navigationController?.pushViewController(detailController, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DetailMovieViewController: UICollectionViewDelegateFlowLayout {
    // swiftlint:disable line_length
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: insets, left: insets, bottom: insets, right: insets)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginAndInsets: CGFloat
        marginAndInsets = minimumInteritemSpacing * 2 + collectionView.safeAreaInsets.left
        + collectionView.safeAreaInsets.right + insets * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        return CGSize(width: itemWidth, height: itemWidth + heightAditionalConstant)
    }
}
