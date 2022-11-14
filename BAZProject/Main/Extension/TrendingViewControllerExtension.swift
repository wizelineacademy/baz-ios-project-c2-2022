//
//  TrendingViewControllerExtension.swift
//  BAZProject
//
//  Created by Mayra Brenda Carreño Mondragon on 14/11/22.
//

import Foundation
import UIKit

protocol collectionMoviesDelegate {
    func presentDetailView (dataMovie: Movie)
}

class cellCollection : UITableViewCell {
    
    @IBOutlet weak var collectionMovies: UICollectionView!
    public let identifierCollection = "SearchCell"
    
    public  var delegatePresentView : collectionMoviesDelegate?
    var movie: [Movie] = []
    
    //MARK: Override methods
    override func awakeFromNib() {
        super.awakeFromNib()
        registerNibs()
        
    }
    
    
    private func registerNibs() {
        collectionMovies.register(UINib(nibName: identifierCollection, bundle: nil), forCellWithReuseIdentifier: identifierCollection)
    }
    
    
}

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
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    //        delegatePresentView?.presentDetailView(dataMovie: movie[indexPath.row])
    //        present(vc, animated: true, completion: nil)
    //   }
    
    
}

