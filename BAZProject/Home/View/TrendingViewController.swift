//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UITableViewController {

    let viewModel = ViewModelMovie()
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateView()
        refreshData()
        
    }
    private func configurateView() {
        viewModel.getInfo(.Trendig)
    }
    
    private func refreshData() {
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
        viewModel.dataArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell")!
    }

}

// MARK: - TableView's Delegate

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = viewModel.dataArray[indexPath.row].title
        config.image = UIImage(data: viewModel.getImage(urlImage: viewModel.dataArray[indexPath.row].poster_path))
        cell.contentConfiguration = config
    }

}
