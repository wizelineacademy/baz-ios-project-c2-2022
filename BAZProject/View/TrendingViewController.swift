//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UITableViewController {
    
    var viewModel = MovieAPI()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        bind()
    }
    
    private func configureView() {
        viewModel.getMovies()
    }
    
    private func bind(){
        viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

}

// MARK: - TableView's DataSource

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.api?.results.count ?? 00
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell")!
    }

}

// MARK: - TableView's Delegate

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        let movie = viewModel.api?.results[indexPath.row]
        config.text = movie?.title
        config.image = UIImage(named: "poster")
        cell.contentConfiguration = config
    }

}
