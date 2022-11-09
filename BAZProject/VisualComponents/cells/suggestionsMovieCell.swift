//
//  suggestionsMovieCell.swift
//  BAZProject
//
//  Created by victor manzanero on 09/11/22.
//

import UIKit

class suggestionsMovieCell: UICollectionViewCell {
    
    
    @IBOutlet weak private var titleSuggestions: UILabel!
    @IBOutlet weak private var imgSuggestions: UIImageView!
    @IBOutlet weak private var detailSuggestions: UILabel!
    static let idReusable: String = "suggestionsMovieCell"
    
    func configure(_ data: MovieEntity ) {
        self.imgSuggestions.loadImage(id: data.posterPath)
        self.titleSuggestions.text = data.title
        self.detailSuggestions.text = ""
    }
    
}
