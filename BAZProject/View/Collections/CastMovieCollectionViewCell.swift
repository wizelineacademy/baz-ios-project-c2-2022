//
//  CastMovieCollectionViewCell.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 26/11/22.
//

import UIKit

class CastMovieCollectionViewCell: UICollectionViewCell {

    static let identifier = "CastMovieCollectionViewCell"
        
    @IBOutlet weak var castProfileImage: UIImageView!
    @IBOutlet weak var castNameLabel: UILabel!
        
    static func nib() -> UINib{
        return UINib(nibName: "CastMovieCollectionViewCell", bundle: nil)
    }
    
    func configureCollection(with person: Cast){
        castNameLabel.text = person.name
        if let profileImage = person.profilePath {
            castProfileImage.setMovieImage(nameImage: profileImage)
        }
    }
}
