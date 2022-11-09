//
//  MovieCollectionViewCell.swift
//  BAZProject
//
//  Created by 1017143 on 21/10/22.
//

import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainCoverImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    func createCardMovie(movie: Movie, url: String) {
        prepareForReuse()
        mainCoverImg.loadImage(urlStr: url)
        titleLbl.text = movie.originalTitle
        subtitle.text = movie.title
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLbl.text = ""
        mainCoverImg.image = nil
        subtitle.text = ""
    }
}
