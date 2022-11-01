//
//  SearchMovieViewController.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 01/11/22.
//

import UIKit

final class SearchMovieViewController: UIViewController {

    @IBOutlet weak var moviesCollection: UICollectionView!
    
    let reuseIdentifier = "movieCollection"
    let itemsPerRow: CGFloat = 3
    let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.moviesCollection.dataSource = self
        self.moviesCollection.delegate = self
    }
}

extension SearchMovieViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MoviesCollectionViewCell else {
            return UICollectionViewCell()
        }
        //cell.imageMovie.image = UIImage(named: "poster")
        //cell.titleMovie.text = "Pelicula \(indexPath.row)"
        return cell
    }
    
    
}

extension SearchMovieViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availiableWidth = view.frame.width - paddingSpace
        let widthPerItem = availiableWidth / itemsPerRow
    
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
}


