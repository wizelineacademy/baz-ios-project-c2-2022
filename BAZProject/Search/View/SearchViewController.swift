//
//  SearchViewController.swift
//  BAZProject
//
//  Created by Alan Emiliano Ramirez Ayala on 01/11/22.
//

import UIKit

final class SearchViewController: UIViewController, PrincipalView {
    
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var CollectionSearchView: UICollectionView! {
        didSet{
            CollectionSearchView.dataSource = self
            CollectionSearchView.delegate = self
        }
    }
    
    let searchViewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateView()
        refreshData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func configurateView() {
        searchViewModel.movieApiDelegate = MovieAPI()
        searchViewModel.getInfo(.Search(query: ""))
    }
    
    func refreshData() {
        searchViewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.CollectionSearchView.reloadData()
            }
            
        }
    }
    
    @IBAction func searchMovies(_ sender: Any) {
        if searchText.text == "" {
            self.present(GenericFunctions.sendAlert("Ingresa la busqueda", "Favor de ingresar la busqueda a realizar"), animated: true, completion: nil)
        } else {
            self.searchViewModel.getInfo(.Search(query: searchText.text ?? ""))
            if self.searchViewModel.dataArray.isEmpty {
                self.present(GenericFunctions.sendAlert("Lo siento", "No se encontro nada relacionado con tu busqueda"), animated: true, completion: nil)
            }
            self.CollectionSearchView.reloadData()
        }
    }
    
}
