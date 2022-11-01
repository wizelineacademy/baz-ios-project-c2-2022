//
//  SearchViewController.swift
//  BAZProject
//
//  Created by Alan Emiliano Ramirez Ayala on 01/11/22.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var SearchBarItem: UISearchBar! {
        didSet {
            SearchBarItem.delegate = self
        }
    }
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
    
    private func configurateView() {
        searchViewModel.getInfo(.Search(query: "Matrix"))
    }
    
    private func refreshData() {
        searchViewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.CollectionSearchView.reloadData()
            }
            
        }
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
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
        present(vc, animated: true, completion: nil)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        SearchBarItem.text = nil
        SearchBarItem.resignFirstResponder()
        CollectionSearchView.resignFirstResponder()
        self.SearchBarItem.showsCancelButton = false
        CollectionSearchView.reloadData()
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.SearchBarItem.showsCancelButton = true
        self.searchViewModel.getInfo(.Search(query: searchText))
        self.CollectionSearchView.reloadData()
    }
    
}
