//
//  CastMovieTableViewCell.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 26/11/22.
//

import UIKit

class CastMovieTableViewCell: UITableViewCell {
    
    static let identifier = "CastMovieTableViewCell"
    
    @IBOutlet weak var castCollection: UICollectionView!
    
    var cast: [Cast] = []
    
    static func nib() -> UINib{
        return UINib(nibName: "CastMovieTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        castCollection.register(CastMovieCollectionViewCell.nib(), forCellWithReuseIdentifier: CastMovieCollectionViewCell.identifier)
        castCollection.delegate = self
        castCollection.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with cast: [Cast]){
        self.cast = cast
        castCollection.reloadData()
        
    }
}

extension CastMovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastMovieCollectionViewCell.identifier, for: indexPath) as! CastMovieCollectionViewCell
        cell.configureCollection(with: cast[indexPath.row])
        return cell
    }
    
    
}
