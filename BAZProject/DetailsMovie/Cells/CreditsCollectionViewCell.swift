//
//  CreditsCollectionViewCell.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 14/11/22.
//

import UIKit

class CreditsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCredits: UIImageView!
    @IBOutlet weak var labelNameActor: UILabel!
    @IBOutlet weak var labelNameCharacter: UILabel!
    
    static let identifier = "CreditsCollectionViewCell"
    static let nameCell = "CreditsCollectionViewCell"
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /// setUpcell
    /// - Parameter actor: info about actor element
    func setUpCell(_ actor: Credit) {
        self.imageCredits.layer.cornerRadius = 25.0
        self.imageCredits.layer.borderColor = .init(red: 94.0/244, green: 223.0/244.0, blue: 98.0/244.0, alpha: 1.0)
        self.imageCredits.layer.borderWidth = 2.0
        ImageAPI.getImage(with: actor.imagePath ?? "") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.imageCredits.image = image
                case .failure(_):
                    self.imageCredits.image = UIImage(systemName: "person.fill")
                }
            }
        }
        self.labelNameActor.text = actor.name
        self.labelNameCharacter.text = actor.nameCharacter
    }

}
