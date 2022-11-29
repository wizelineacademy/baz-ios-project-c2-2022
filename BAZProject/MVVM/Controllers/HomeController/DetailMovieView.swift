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
    @IBOutlet weak var segmentLenguaje: UISegmentedControl!
    lazy var alert: CustomAlertViewController = {
        DispatchQueue.main.sync {
            return CustomAlertViewController()
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.config()
        self.setupObservables()
    }
    
    private func config() {
        getDataDetail()
        sugestionsMoviesColletion.register( UINib(nibName: SuggestionsMovieCell.idReusable , bundle: nil) , forCellWithReuseIdentifier: SuggestionsMovieCell.idReusable)
        sugestionsMoviesColletion.delegate = self
        sugestionsMoviesColletion.dataSource = self
    }
    
    private func getDataDetail() {
        viewModel?.getDetail()
        viewModel?.getSimilar()
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
            DispatchQueue.main.sync {
                self.present(self.alert , animated: true)
            }
        }.dispose(in: bag)
        
        viewModel.similar.observeNext { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.sugestionsMoviesColletion.reloadData()
            }
        }.dispose(in: bag)
        
        viewModel.language.observeNext{ [weak self] response in
            guard let response =  response, let self = self else { return }
            NotificationCenter.default.post(name: .didLanguageChange, object: nil, userInfo: ["language": response.rawValue])
            self.getDataDetail()
        }.dispose(in: bag)
    }
    
    private func setDetail(data: DetailMovieEntity) {
        DispatchQueue.main.async {
            self.titleMovie.text = data.title
            self.imgMovie.loadImage(id: data.posterPath)
            self.voteAverage.text = "\(StaticLabel.lblPoint)\(data.voteAverage)"
            self.timeMovie.text = "\(StaticLabel.lblMinutes)\(data.runtime)"
            self.voteCount.text = "\(StaticLabel.lblvoteCount)\(data.voteCount)"
            self.descriptionMovie.text = data.overview
        }
    }
    
    @IBAction func changeLenguaje(_ sender: Any) {
        viewModel?.chengeLanguage(id: segmentLenguaje.selectedSegmentIndex)
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
