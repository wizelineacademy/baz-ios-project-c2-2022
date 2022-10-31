//
//  DetailsMovieViewController.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 25/10/22.
//

import UIKit

final class DetailsMovieViewController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var presenter: DetailsMoviePresenterProtocols?
    var movie: Movie?
    private let movieApi = MovieAPI()
    
    init(movie: Movie) {
        super.init(nibName: nil, bundle: nil)
        self.movie = movie
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let info = movie else {
            self.dismiss(animated: true)
            return
        }
        self.backgroundImage.image = movieApi.getImage(with: info.posterPath)
        self.titleLbl.text = info.title
        self.descriptionLbl.text = info.overview
    }
}

extension DetailsMovieViewController: DetailsMovieViewProtocols {
    
}
