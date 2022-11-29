//
//  MovieListCollectionViewCellExtensions.swift
//  BAZProject
//
//  Created by 1028092 on 10/11/22.
//

import Foundation
import UIKit

extension UIStackView{
    func changePosition(position: NSLayoutConstraint.Axis) -> UIStackView{
        let stackView = UIStackView()
        stackView.axis = position
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.borderColor = UIColor.white.cgColor
        return stackView
    }
}

extension UIImageView{
    func styleImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }
}

extension UILabel{
    func styleLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }
}

extension UIImageView {
    func detailImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }
}

extension UITextView {
    func detailTextView() -> UITextView {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = 15
        textView.layer.masksToBounds = true
        textView.font = UIFont.systemFont(ofSize: 12)
        textView.textAlignment = .justified
        textView.sizeToFit()
        textView.textColor = .gray
        textView.isScrollEnabled = true
        textView.isEditable = false
        return textView
    }
}
