//
//  DetailMovieView.swift
//  BAZProject
//
//  Created by victor manzanero on 09/11/22.
//

import UIKit

class DetailMovieView: UIViewController {
    
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
        self.viewModel = DetailMovieViewModel(usecase: ApiUseCase())
        self.viewModel?.getDetail(id: self.idMovie ?? 0)
        self.viewModel?.getSimilar(id: self.idMovie ?? 0)
        self.sugestionsMoviesColletion.register( UINib(nibName: suggestionsMovieCell.idReusable , bundle: nil) , forCellWithReuseIdentifier: suggestionsMovieCell.idReusable)
        self.sugestionsMoviesColletion.delegate = self
        self.sugestionsMoviesColletion.dataSource = self
    }
    
    private func setupObservables() {
        self.viewModel?.response.observeNext {[weak self] response in
            if let _ = response {
                self?.setDetail(data: response!)
            }
        }.dispose(in: bag)
        
        self.viewModel?.error.observeNext{ [weak self] response in
            if let error = response {
                self?.alert.alertStyle = .error
                self?.alert.bodyText = error.message
                self?.present(self?.alert ?? UIViewController(), animated: true)
            }
        }.dispose(in: bag)
        
        self.viewModel?.similar.observeNext { [weak self] response in
                self?.sugestionsMoviesColletion.reloadData()
        }.dispose(in: bag)
    }
    
    private func setDetail(data: DetailMovieEntity) {
        self.titleMovie.text = data.title
        self.imgMovie.loadImage(id: data.posterPath)
        self.voteAverage.text = "\(staticLabel.lblPoint)\(data.voteAverage)"
        self.timeMovie.text = "\(staticLabel.lblMinutes)\(data.runtime)"
        self.voteCount.text = "\(staticLabel.lblvoteCount)\(data.voteCount)"
        self.descriptionMovie.text = data.overview
    }
}

extension DetailMovieView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.similar.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.viewModel?.similar.value else { return UICollectionViewCell () }
        if let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: suggestionsMovieCell.idReusable, for: indexPath) as? suggestionsMovieCell {
            let item = cell[indexPath.row]
            movieCell.configure(item)
            return movieCell
        } else {
            return UICollectionViewCell()
        }
    }
}
