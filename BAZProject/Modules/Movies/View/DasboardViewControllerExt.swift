//
//  DasboardViewControllerExt.swift
//  BAZProject
//
//  Created by 1017143 on 25/10/22.
//

import UIKit

extension DasboardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviePresenter.getSearchedMovies()
    }
    // swiftlint:disable:next line_length
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocalizableKeys.Home.collection,
                                                            for: indexPath as IndexPath) as? MovieCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        if let url = moviePresenter.getUrlImgeMovie(indexPath: indexPath.row, size: .middle),
           let movie = moviePresenter.getMovie(indexPath: indexPath.row, type: .collection) {
            cell.createCardMovie(movie: movie, url: url)
        }
        return cell
    }
}

extension DasboardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = DetailMovieViewController.getViewController()
        if let movie = moviePresenter.getMovie(indexPath: indexPath.row, type: .collection),
           let url = moviePresenter.getUrlImgeMovie(indexPath: indexPath.row, size: .middle) {
            detailController.movie = movie
            detailController.urlImg = url
            NotificationCenter.default.post(name: NSNotification.Name("Movies.save"),
                                            object: nil, userInfo: ["movie": movie])
        }
        self.navigationController?.pushViewController(detailController, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DasboardViewController: UICollectionViewDelegateFlowLayout {
    // swiftlint:disable line_length
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Insets.insets, left: Insets.insets, bottom: Insets.insets, right: Insets.insets)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Insets.minimumLineSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Insets.minimumInteritemSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginAndInsets: CGFloat
        marginAndInsets = Insets.minimumInteritemSpacing * 2
        + collectionView.safeAreaInsets.left
        + collectionView.safeAreaInsets.right + Insets.insets * CGFloat(Insets.cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginAndInsets) / CGFloat(Insets.cellsPerRow)).rounded(.down)
        return CGSize(width: itemWidth, height: itemWidth + Insets.heightAditionalConstant)
    }
}
