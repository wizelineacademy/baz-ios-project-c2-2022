//
//  DetailMovieViewController.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 13/11/22.
//

import UIKit

class DetailMovieViewController: UIViewController {
    
    @IBOutlet weak var imgBackdropPath: UIImageView!
    
    @IBOutlet weak var collectionViewSimilar: UICollectionView!
    @IBOutlet weak var txtOverview: UITextView!
    @IBOutlet weak var btnAddFavorites: UIButton!
    @IBOutlet weak var lblTitleMovie: UILabel!
    var viewModel = DetailViewModel()
    var movie: Movie = Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSimilar.register(MoviesCollectionViewCell.nib(), forCellWithReuseIdentifier:  MoviesCollectionViewCell.identifier)
        collectionViewSimilar.delegate = self
        collectionViewSimilar.dataSource = self
        viewModel.loadSimilarMovies(idMovie: movie.id ?? 1)
        loadDataMovie()
        
    }
    
    private func loadDataMovie(){
        lblTitleMovie.text = movie.title
        txtOverview.text = movie.overview
        if let backdropPath = movie.backdropPath{
            imgBackdropPath.setMovieImage(nameImage: backdropPath)
        }
    }
}

extension DetailMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.similar.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier, for: indexPath) as! MoviesCollectionViewCell
        cell.configureCollection(with: viewModel.similar[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 300)
    }
    
    
}


