//
//  SearchMovieViewCell.swift
//  BAZProject
//
//  Created by 1030364 on 02/11/22.
//

import UIKit

final class SearchMovieViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(with image: UIImage) {
        posterImage.layer.cornerRadius = 10.0
        posterImage.image = image
    }

    static func nib() -> UINib {
        return UINib(nibName: "SearchMovieViewCell", bundle: nil)
    }

}
