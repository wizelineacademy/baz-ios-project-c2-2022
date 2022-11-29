//
//  suggestionsMovieCell.swift
//  BAZProject
//
//  Created by victor manzanero on 09/11/22.
//

import UIKit

final class SuggestionsMovieCell: UICollectionViewCell {
    
    @IBOutlet weak private var titleSuggestions: UILabel!
    @IBOutlet weak private var imgSuggestions: UIImageView!
    static let idReusable: String = "suggestionsMovieCell"
    
    func configure(_ data: MovieEntity ) {
        self.imgSuggestions.loadImage(id: data.poster_path)
        self.titleSuggestions.text = data.title
    }
    
}
