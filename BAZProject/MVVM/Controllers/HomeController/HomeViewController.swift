//
//  HomeViewController.swift
//  BAZProject
//
//  Created by victor manzanero on 07/11/22.
//

import UIKit
import Bond

class HomeViewController: UIViewController {

    @IBOutlet weak var movieTable: UITableView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myPicker: UIPickerView!
    @IBOutlet weak var myToolbar: UIToolbar!
    @IBOutlet weak var btnDone: UIBarButtonItem!
    @IBOutlet weak var btnCancel: UIBarButtonItem!
    
    var viewModel: HomeViewModel?
    lazy var alert: CustomAlertViewController = {
        return CustomAlertViewController()
    }()
    
    override func viewDidLoad() {
        self.config()
        self.setupObservables()
        self.setupObservablesAction()
    }
    
    func config() {
        self.viewModel = HomeViewModel(usecase: ApiUseCase())
        self.movieTable.register( UINib(nibName: MoviesCell.idReusable , bundle: nil) , forCellReuseIdentifier: MoviesCell.idReusable)
        self.movieTable.delegate = self
        self.movieTable.dataSource = self
        self.searchBar.delegate = self
        self.myPicker.delegate = self
        self.myPicker.dataSource = self
        self.viewModel?.getMovies()
    }
    
    fileprivate func setupObservables() {
        self.viewModel?.response.observeNext{ [weak self] response in
            if let _ = response {
                self?.movieTable.reloadData()
            }
        }.dispose(in: bag)
        
        self.viewModel?.loading.observeNext{ [weak self] response in
            switch response {
            case .fullScreen:
                self?.loadingView.isHidden = false
                self?.loadingView.startAnimating()
            case .hide:
                self?.loadingView.isHidden = true
                self?.loadingView.stopAnimating()
            }
        }.dispose(in: bag)
        
        self.viewModel?.error.observeNext{ [weak self] response in
            if let error = response {
                self?.alert.alertStyle = .error
                self?.alert.bodyText = error.message
                self?.alert.customAlertDelegate = self
                self?.present(self?.alert ?? UIViewController(), animated: true)
            }
        }.dispose(in: bag)
        
        self.viewModel?.title.observeNext { [weak self] response in
            if let _ = response {
                self?.navigationItem.title = response
                self?.enablePicker()
            }
        }.dispose(in: bag)
    }
    
    @IBAction func showPicker(_ sender: Any) {
        self.enablePicker()
    }
    
    fileprivate func setupObservablesAction() {
        self.btnCancel.reactive.tap.observeNext{ [weak self] in
            self?.enablePicker()
        }.dispose(in: bag)
        
        self.btnDone.reactive.tap.observeNext{[weak self] in
            self?.viewModel?.getMoviesCategory()
        }.dispose(in: bag)
    }
    
    func enablePicker(){
        self.myPicker.isHidden = !self.myPicker.isHidden
        self.myToolbar.isHidden = !self.myToolbar.isHidden
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.response.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.viewModel?.response.value else { return UITableViewCell () }
        if let movieCell = tableView.dequeueReusableCell(withIdentifier: MoviesCell.idReusable, for: indexPath) as? MoviesCell {
            let item = cell[indexPath.row]
            movieCell.configure(item)
            return movieCell
        } else {
            return UITableViewCell()
        }
    }
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.returnKeyType = .search
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let string =  self.searchBar?.text ?? ""
        self.viewModel?.searchMovie(query: string)
        self.view.endEditing(true)
    }
}

extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.viewModel?.getText(index: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       self.viewModel?.getType(index: row)
    }
    
}

extension HomeViewController: CustomProtocol {
    func doneClick() {
        self.alert.dismiss(animated: true)
        self.searchBar.text = ""
    }
}
