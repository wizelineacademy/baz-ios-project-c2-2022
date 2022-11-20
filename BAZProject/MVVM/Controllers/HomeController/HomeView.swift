//
//  HomeView.swift
//  BAZProject
//
//  Created by victor manzanero on 07/11/22.
//

import UIKit
import Bond

final class HomeViewController: UIViewController {

    @IBOutlet weak var movieTable: UITableView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myPicker: UIPickerView!
    @IBOutlet weak var myToolbar: UIToolbar!
    @IBOutlet weak var btnDone: UIBarButtonItem!
    @IBOutlet weak var btnCancel: UIBarButtonItem!
    
    weak var detailNavigato: DetailNavigator?
    var viewModel: HomeViewModel?
    lazy var alert: CustomAlertViewController = {
        return CustomAlertViewController()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.config()
        self.setupObservables()
        self.setupObservablesAction()
    }
    
    func config() {
        movieTable.register( UINib(nibName: MoviesCell.idReusable , bundle: nil) , forCellReuseIdentifier: MoviesCell.idReusable)
        movieTable.delegate = self
        movieTable.dataSource = self
        searchBar.delegate = self
        myPicker.delegate = self
        myPicker.dataSource = self
        viewModel?.getMovies()
    }
    
    fileprivate func setupObservables() {
        guard let viewModel = viewModel else { return }
        viewModel.response.observeNext{ [weak self] response in
            guard let _ =  response, let self = self else { return }
            self.movieTable.reloadData()
        }.dispose(in: bag)
        
        viewModel.loading.observeNext{ [weak self] response in
            guard let self = self else { return }
            self.loadingView.isHidden = response
        }.dispose(in: bag)
        
        viewModel.error.observeNext{ [weak self] response in
            guard let response =  response, let self = self else { return }
            self.alert.alertStyle = .error
            self.alert.bodyText = response.message
            self.alert.doneCustomAlertDelegate = self
            self.present(self.alert , animated: true)
        }.dispose(in: bag)
        
        viewModel.title.observeNext { [weak self] response in
            guard let response =  response, let self = self else { return }
            self.navigationItem.title = response
            self.enablePicker()
        }.dispose(in: bag)
    }
    
    @IBAction func showPicker(_ sender: Any) {
        self.enablePicker()
    }
    
    fileprivate func setupObservablesAction() {
        self.btnCancel.reactive.tap.observeNext{ [weak self] in
            self?.enablePicker()
        }.dispose(in: bag)
        
        self.btnDone.reactive.tap.observeNext{ [weak self] in
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
        guard let cellModels = self.viewModel?.response.value, let movieCell = tableView.dequeueReusableCell(withIdentifier: MoviesCell.idReusable, for: indexPath) as? MoviesCell else { return UITableViewCell () }
        let cellModel = cellModels[indexPath.row]
        movieCell.configure(cellModel, moviesCellDelegate: self)
        return movieCell
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

extension HomeViewController: DoneCustomAlertProtocol {
    func doneClick() {
        self.alert.dismiss(animated: true)
        self.searchBar.text = ""
    }
}

extension HomeViewController: MoviesCellProtocol {
    func selectMovie(id: Int) {
        self.detailNavigato?.gotoDetail(id: id)
    }
}
