//
//  MoviesCategoriesTableViewCell.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 04/11/22.
//

import UIKit

protocol CollectionViewCellDelegate: AnyObject {
    func collectionView(_ movie: Movie)
}

class MoviesCategoriesTableViewCell: UITableViewCell {
    
    static let identifier = "MoviesCategoriesTableViewCell"
    
    @IBOutlet weak var categoryCollection: UICollectionView!
    weak var cellDelegate: CollectionViewCellDelegate?
    
    var viewModel = HomeViewModel()
        
    @IBOutlet weak var MovieCategoryNameLabel: UILabel!
    
    var movies : [Movie] = []
    
    static func nib() -> UINib{
        return UINib(nibName: "MoviesCategoriesTableViewCell", bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryCollection.register(MoviesCollectionViewCell.nib(), forCellWithReuseIdentifier: MoviesCollectionViewCell.identifier)
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with movies : [Movie]){
        self.movies = movies
        categoryCollection.reloadData()
    }
    
}

extension MoviesCategoriesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier, for: indexPath) as! MoviesCollectionViewCell
        cell.configureCollection(with: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? UICollectionViewCell
        self.cellDelegate?.collectionView(movies[indexPath.row])
    }
}

