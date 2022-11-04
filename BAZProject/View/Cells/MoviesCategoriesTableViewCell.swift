//
//  MoviesCategoriesTableViewCell.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 04/11/22.
//

import UIKit

class MoviesCategoriesTableViewCell: UITableViewCell {
    
    static let identifier = "MoviesCategoriesTableViewCell"
    
    @IBOutlet weak var categoryCollection: UICollectionView!
        
    @IBOutlet weak var btnSeeMore: UIButton!
    @IBOutlet weak var lblNameCategory: UILabel!
    
    var movies : [Movie] = []
    
    static func nib() -> UINib{
        return UINib(nibName: "MoviesCategoriesTableViewCell", bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryCollection.register(MoviesCollectionViewCell.nib(), forCellWithReuseIdentifier: MoviesCollectionViewCell.identifier)
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with movies : [Movie]){
        self.movies = movies
        categoryCollection.reloadData()
    }
    
}

extension MoviesCategoriesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier, for: indexPath) as! MoviesCollectionViewCell
        cell.configureCollection(with: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 300)
    }
    
}
