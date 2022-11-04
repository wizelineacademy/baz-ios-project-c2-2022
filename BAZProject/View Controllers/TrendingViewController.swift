//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UITableViewController {
    
    var viewModel = ViewModelMovies()
    
    @IBOutlet var moviesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
    }
    
    private func configureView() {
        moviesTable.register(MoviesCategoriesTableViewCell.nib(), forCellReuseIdentifier: MoviesCategoriesTableViewCell.identifier)
        moviesTable.delegate = self
        moviesTable.dataSource = self
        viewModel.retriveMoviesList()
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
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesTable.dequeueReusableCell(withIdentifier: MoviesCategoriesTableViewCell.identifier, for: indexPath) as! MoviesCategoriesTableViewCell
        cell.lblNameCategory.text = "Trending"
        cell.configure(with: viewModel.movies)
        return cell
    }

}

