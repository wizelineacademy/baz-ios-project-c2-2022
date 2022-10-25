//
//  DetailViewController.swift
//  BAZProject
//
//  Created by Alan Emiliano Ramirez Ayala on 21/10/22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var backArrowButtom: UIBarButtonItem!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var tituloDetailView: UILabel!
    @IBOutlet weak var tituloOriginalDetail: UILabel!
    @IBOutlet weak var clificacionDetailView: UILabel!
    @IBOutlet weak var fechaEstrenoDetail: UILabel!
    @IBOutlet weak var descDetailView: UILabel!
    
    let viewModel = DetailModelView()
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func returnListMovie(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    private func configurateView() {
        tituloDetailView.text = self.viewModel.dataArray?.title
        tituloOriginalDetail.text = self.viewModel.dataArray?.original_title
        clificacionDetailView.text = "Calificaion \(self.viewModel.dataArray?.vote_average ?? 0.0)"
        fechaEstrenoDetail.text = self.viewModel.dataArray?.release_date
        descDetailView.text = self.viewModel.dataArray?.overview
        imageMovie.image = UIImage(data: self.viewModel.getImage(urlImage: viewModel.dataArray?.poster_path ?? "")) ?? UIImage(named: "poster")
    }
}
