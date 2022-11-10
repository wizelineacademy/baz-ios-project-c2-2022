//
//  DetailsMovieViewController.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 25/10/22.
//

import UIKit

protocol DetailsMovieDelegate {
    func addIdMovie(_ idMovie: Int)
    func removeIdMoview(_ idMovie: Int)
}

final class DetailsMovieViewController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var btnLikedMovie: UIButton!
    
    var presenter: DetailsMoviePresenterProtocols?
    var movie: Movie?
    var delegate: DetailsMovieDelegate?
    var likedMovie: Bool = false
    
    init(movie: Movie, delegado: DetailsMovieDelegate, like: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.movie = movie
        self.delegate = delegado
        self.likedMovie = like
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        var moviesCount = UserDefaults.standard.integer(forKey: "countMovies")
        moviesCount += 1
        UserDefaults.standard.set(moviesCount, forKey: "countMovies")
        presenter?.setUpPresentToInteractor()
        NotificationCenter.default.post(name: .countMovieDetails, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func clickLikedMovie() {
        presenter?.btnLikedClick()
    }
}

extension DetailsMovieViewController: DetailsMovieViewProtocols {
    var viewInterface: DetailsMovieViewController? {
        return self
    }
}
