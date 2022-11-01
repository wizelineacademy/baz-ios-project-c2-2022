//
//  MoviesCollectionViewCell.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 01/11/22.
//

import UIKit

final class MoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imageMovie.image = UIImage(named: "poster")
    }

}
