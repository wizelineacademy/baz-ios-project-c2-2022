//
//  HeaderViewCell.swift
//  BAZProject
//
//  Created by 1028092 on 16/11/22.
//

import UIKit

class HeaderViewCell: UICollectionReusableView {
    static let identifier = String(describing: HeaderViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: HeaderViewCell.self), bundle: nil)
    }
    @IBOutlet weak var lblHeader: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
