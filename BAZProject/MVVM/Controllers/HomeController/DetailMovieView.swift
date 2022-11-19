//
//  DetailMovieView.swift
//  BAZProject
//
//  Created by victor manzanero on 09/11/22.
//

import UIKit

final class DetailMovieView: UIViewController {
    
    var idMovie: Int?
    var viewModel: DetailMovieViewModel?
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var voteAverage: UILabel!
    @IBOutlet weak var timeMovie: UILabel!
    @IBOutlet weak var voteCount: UILabel!
    @IBOutlet weak var descriptionMovie: UITextView!
    @IBOutlet weak var sugestionsMoviesColletion: UICollectionView!
    lazy var alert: CustomAlertViewController = {
        return CustomAlertViewController()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.config()
        self.setupObservables()
    }
    
    func config() {
        viewModel?.getDetail()
        viewModel?.getSimilar()
        sugestionsMoviesColletion.register( UINib(nibName: SuggestionsMovieCell.idReusable , bundle: nil) , forCellWithReuseIdentifier: SuggestionsMovieCell.idReusable)
        sugestionsMoviesColletion.delegate = self
        sugestionsMoviesColletion.dataSource = self
    }
    
    private func setupObservables() {
        guard let viewModel = viewModel else { return }
        viewModel.response.observeNext {[weak self] response in
            guard let response =  response, let self = self else { return }
            self.setDetail(data: response)
        }.dispose(in: bag)
        
        viewModel.error.observeNext{ [weak self] response in
            guard let response =  response, let self = self else { return }
            self.alert.alertStyle = .error
            self.alert.bodyText = response.message
            self.present(self.alert , animated: true)
        }.dispose(in: bag)
        
        viewModel.similar.observeNext { [weak self] response in
            guard let response =  response, let self = self else { return }
            self.sugestionsMoviesColletion.reloadData()
        }.dispose(in: bag)
    }
    
    private func setDetail(data: DetailMovieEntity) {
        titleMovie.text = data.title
        imgMovie.loadImage(id: data.posterPath)
        voteAverage.text = "\(StaticLabel.lblPoint)\(data.voteAverage)"
        timeMovie.text = "\(StaticLabel.lblMinutes)\(data.runtime)"
        voteCount.text = "\(StaticLabel.lblvoteCount)\(data.voteCount)"
        descriptionMovie.text = data.overview
    }
}

extension DetailMovieView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.similar.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.viewModel?.similar.value else { return UICollectionViewCell () }
        if let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: SuggestionsMovieCell.idReusable, for: indexPath) as? SuggestionsMovieCell {
            let item = cell[indexPath.row]
            movieCell.configure(item)
            return movieCell
        } else {
            return UICollectionViewCell()
        }
    }
}