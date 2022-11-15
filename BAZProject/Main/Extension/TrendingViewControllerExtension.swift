//
//  TrendingViewControllerExtension.swift
//  BAZProject
//
//  Created by Mayra Brenda Carreño Mondragon on 14/11/22.
//

import Foundation
import UIKit

class cellCollection : UITableViewCell {
    @IBOutlet weak var collectionMovies: UICollectionView!
    
    // MARK: - Properties
    public let identifierCollection = "SearchCell"
    var movie: [Movie] = []
    
    //MARK: Override methods
    override func awakeFromNib() {
        super.awakeFromNib()
        registerNibs()
        
    }
    /// Register the custom cell
    private func registerNibs() {
        collectionMovies.register(UINib(nibName: identifierCollection, bundle: nil), forCellWithReuseIdentifier: identifierCollection)
    }
}
// MARK: - CollectionView Delegate
extension cellCollection : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierCollection , for: indexPath) as? SearchCell else {
            return UICollectionViewCell()
        }
        cell.getInfoCollection(movie: movie[indexPath.row].mapToViewData())
        
        return cell
    }
}

