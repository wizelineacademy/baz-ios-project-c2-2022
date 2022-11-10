//
//  DetailsMovieInteractor.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 25/10/22.
//

import Foundation
import UIKit

final class DetailsMovieInteractor: DetailsMovieInteractorInputAndOutputProtocols {
    var view: DetailsMovieViewProtocols?
    var presenter: DetailsMoviePresenterProtocols?
    private let imageApi = ImageAPI()
    
    func setUpPresentToInteractor() {
        guard let info = view?.viewInterface?.movie, let interface = view?.viewInterface else {
            view?.viewInterface?.dismiss(animated: true, completion: nil)
            return
        }
        let posterPath = info.backdropPath ?? "poster"
        imageApi.getImage(with: posterPath) { result in
            switch result {
            case .success(let image):
                interface.backgroundImage.image = image
            case .failure(_):
                interface.backgroundImage.image = UIImage(named: "poster")
            }
        }
        interface.titleLbl.text = info.title
        interface.descriptionLbl.text = info.overview
        let imageLiked = interface.likedMovie ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        interface.btnLikedMovie.setImage(imageLiked, for: .normal)
    }
    
    func btnLikedClick() {
        guard let interface = view?.viewInterface else { return }
        interface.likedMovie = !interface.likedMovie
        let imageLiked = interface.likedMovie ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        interface.btnLikedMovie.setImage(imageLiked, for: .normal)
        if interface.likedMovie {
            interface.delegate?.addIdMovie(interface.movie?.id ?? -1)
        } else {
            interface.delegate?.removeIdMoview(interface.movie?.id ?? -1)
        }
    }
}
