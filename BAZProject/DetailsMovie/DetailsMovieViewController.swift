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
    var fromVC: fromViewController?
    private let movieApi = MovieAPI()
    
    init(movie: Movie, vc: fromViewController) {
        super.init(nibName: nil, bundle: nil)
        self.movie = movie
        self.fromVC = vc
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        let contadorNotification = ["cont": movie?.id]
        if self.fromVC == .moviesCategory {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "contadorToVCCategory"), object: contadorNotification)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "contadorToVCSearch"), object: contadorNotification)
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let info = movie else {
            self.dismiss(animated: true)
            return
        }
        let posterPath = info.backdropPath ?? "poster"
        self.backgroundImage.image = movieApi.getImage(with: posterPath)
        self.titleLbl.text = info.title
        self.descriptionLbl.text = info.overview
    }
}

extension DetailsMovieViewController: DetailsMovieViewProtocols {
    
}
