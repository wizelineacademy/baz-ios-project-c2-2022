//
//  DetailsMovieViewController.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 25/10/22.
//

import UIKit

class DetailsMovieViewController: UIViewController {
    
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var presenter: DetailsMoviePresenterProtocols?
    var details: detailsMovie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        // Do any additional setup after loading the view.
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let info = details else {
            self.dismiss(animated: true)
            return
        }
        self.backgroundImage.image = info.backgroundImage
        self.titleLbl.text = info.title
        self.descriptionLbl.text = info.description
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailsMovieViewController: DetailsMovieViewProtocols {
    
}
