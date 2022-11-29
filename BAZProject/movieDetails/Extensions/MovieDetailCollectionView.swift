//
//  MovieDetailCollectionView.swift
//  BAZProject
//
//  Created by 1028092 on 23/11/22.
//
import UIKit
extension MovieDetailViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier, for: indexPath) as? ReviewTableViewCell else { return .init() }
        DispatchQueue.main.async {
            guard let setMovies = self.presenter?.generateListMovie(section: indexPath.section) else { return }
            cell.setup(reviews: setMovies, delegate: self)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let count = presenter?.setMoviesRecommendations.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240.0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        
        return self.presenter?.setMoviesRecommendations[section]
    }
}
    


extension MovieDetailViewController: ReviewCollectionSelectedProtocol {
    
    /// This function receive parameter viewController
    /// - parameters
    ///      - indexPath: position of the array
    ///      - listMovies: array model Movie
    func didSelectReview(at indexPath: IndexPath, listReviews: [Movie]) {
        self.presenter?.navigationToDetailMovie(at: indexPath, listMovies: listReviews, from: self)
    }
}
