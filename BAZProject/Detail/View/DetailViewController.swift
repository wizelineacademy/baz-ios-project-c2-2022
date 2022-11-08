//
//  DetailViewController.swift
//  BAZProject
//
//  Created by Alan Emiliano Ramirez Ayala on 21/10/22.
//

import UIKit 

class DetailViewController: UIViewController, GenericView {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var BackDetailTopView: UIView!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var tituloDetailView: UILabel!
    @IBOutlet weak var tituloOriginalDetail: UILabel!
    @IBOutlet weak var clificacionDetailView: UILabel!
    @IBOutlet weak var fechaEstrenoDetail: UILabel!
    @IBOutlet weak var descDetailView: UILabel!
    
    let detailViewModel = DetailModelView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail"
        configurateView()
    }
    
    func configurateView() {
        stackView.layer.cornerRadius = 15
        BackDetailTopView.addBlurToView()
        BackDetailTopView.backgroundColor = UIColor(patternImage: UIImage(data: self.detailViewModel.getImage(urlImage: detailViewModel.dataArray?.backdropPath ?? "")) ?? UIImage())
        tituloDetailView.text = "  \(self.detailViewModel.dataArray?.title ?? "")"
        tituloOriginalDetail.text = "  \(self.detailViewModel.dataArray?.originalTitle ?? "")"
        clificacionDetailView.text = "  Calificaion \(self.detailViewModel.dataArray?.voteAverage ?? 0.0)"
        fechaEstrenoDetail.text = "  \(self.detailViewModel.dataArray?.releaseDate ?? "")"
        descDetailView.text = "\(self.detailViewModel.dataArray?.overview ?? "")"
        imageMovie.image = UIImage(data: self.detailViewModel.getImage(urlImage: detailViewModel.dataArray?.posterPath ?? "")) ?? UIImage(named: "poster")
    }
}
