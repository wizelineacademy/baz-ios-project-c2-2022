//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UIViewController {
    
    @IBOutlet var tblMovie: UITableView!{
        didSet{
            tblMovie.delegate = self
            tblMovie.dataSource = self
            registerNibs()
        }
    }
    
    let movieApi = MovieAPI()
    let identifier = "TrendingTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieApi.getMovies()
        movieApi.refreshData = { [weak self]() in
            DispatchQueue.main.async {
                self?.tblMovie.reloadData()
            }
        }
    }
    
    private func registerNibs() {
        tblMovie.register(UINib(nibName: "TrendingTableViewCell", bundle: nil), forCellReuseIdentifier: "TrendingTableViewCell")
       }
}

// MARK: - TableView's DataSource

extension TrendingViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieApi.dataMovie?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TrendingTableViewCell else{ return UITableViewCell() }
        let info = movieApi.dataMovie?.results[indexPath.row]
        cell.lblTitle.text = info?.title
        return cell
    }
}
