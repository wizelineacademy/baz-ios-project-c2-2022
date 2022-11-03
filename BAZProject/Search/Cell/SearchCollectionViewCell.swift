//
//  SearchCollectionViewCell.swift
//  BAZProject
//
//  Created by Alan Emiliano Ramirez Ayala on 01/11/22.
//

import UIKit
import SkeletonView
class SearchCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public var movieModel: Movie? {
        didSet { configure() }
    }
    
    private var movieViewModel = ViewModelMovie()
    
    func configureData(titulo: String, image: UIImage) {
        self.image.image = image
        self.title.text = titulo
    }
    
    func setUpSkeleton() {
        self.image.isSkeletonable = true
        self.title.isSkeletonable = true
        self.title.linesCornerRadius = 8
    }
    
    private func configure() {
        guard let movieModel = movieModel else { return }
        let imageMovie = UIImage(data: self.movieViewModel.getImage(urlImage: movieModel.posterPath)) ?? UIImage(named: "poster")
        self.configureData(titulo: movieModel.title, image: imageMovie ?? UIImage())
    }
    

}
