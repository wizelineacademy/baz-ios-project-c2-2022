//
//  SearchTableViewCell.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 15/11/22.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    static let identifier = "SearchTableViewCell"
    
    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    static func nib() -> UINib{
        return UINib(nibName: "SearchTableViewCell", bundle: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
