//
//  MovieDetailsExtension.swift
//  BAZProject
//
//  Created by 1028092 on 18/11/22.
//

import UIKit
extension MovieDetailViewController {
    
    /// This function dot not receive parameter setContraints
    /// - parameters
     func setContraints() {
         NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            scrollView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, constant: 0),
            scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 5),
            scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            scrollStackViewContainer.heightAnchor.constraint(equalTo: scrollView.heightAnchor, constant: 0),
            scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: 0),
            scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            
            titleLabel.topAnchor.constraint(equalTo: scrollStackViewContainer.topAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            titleLabel.leftAnchor.constraint(equalTo: scrollStackViewContainer.leftAnchor, constant: 15),
            titleLabel.rightAnchor.constraint(equalTo: scrollStackViewContainer.rightAnchor,constant: -15),
            
            
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalToConstant: (view.frame.height / 4)),
            imageView.leftAnchor.constraint(equalTo: scrollStackViewContainer.leftAnchor, constant: -15),
            
            subtitleLabel.heightAnchor.constraint(equalToConstant: 30),
            subtitleLabel.leftAnchor.constraint(equalTo: scrollStackViewContainer.leftAnchor, constant: 15),
            
            textView.heightAnchor.constraint(equalToConstant: 100),
            textView.leftAnchor.constraint(equalTo: scrollStackViewContainer.leftAnchor, constant: 15),
            textView.rightAnchor.constraint(equalTo: scrollStackViewContainer.rightAnchor,constant: -15),
            
            tableView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 0),
            tableView.heightAnchor.constraint(equalToConstant: (view.frame.height / 2)),
            tableView.leftAnchor.constraint(equalTo: scrollStackViewContainer.leftAnchor, constant: 15),
            
        ])
    }
}

