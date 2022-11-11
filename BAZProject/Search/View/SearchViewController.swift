//
//  SearchViewController.swift
//  BAZProject
//
//  Created by Alan Emiliano Ramirez Ayala on 01/11/22.
//

import UIKit

class SearchViewController: UIViewController, PrincipalView {
    
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
            sendAlert("Ingresa la busqueda", "Favor de ingresar la busqueda a realizar")
        } else {
            self.searchViewModel.getInfo(.Search(query: searchText.text ?? ""))
            if self.searchViewModel.dataArray.isEmpty {
                sendAlert("Lo siento", "No se encontro nada relacionado con tu busqueda")
            }
            self.CollectionSearchView.reloadData()
        }
    }
    
    func sendAlert(_ title: String,_ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.searchViewModel.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.CollectionSearchView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
        cell.setUpSkeleton()
        cell.image.showAnimatedGradientSkeleton()
        cell.title.showAnimatedGradientSkeleton()
        DispatchQueue.main.asyncAfter(deadline: .now()) { [self] in
            cell.image.hideSkeleton()
            cell.title.hideSkeleton()
            cell.movieModel = searchViewModel.dataArray[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.detailViewModel.dataArray = searchViewModel.dataArray[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        //        present(vc, animated: true, completion: nil)
    }
    
}
