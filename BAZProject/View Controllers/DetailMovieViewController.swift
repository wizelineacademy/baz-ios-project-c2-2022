//
//  DetailsMovieViewController.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 26/11/22.
//

import UIKit

class DetailMovieViewController: UIViewController {

    @IBOutlet weak var tableDetailsMovie: UITableView!
    var viewModel = DetailViewModel()
    var movie: Movie = Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
    }
        
    private func configureView(){
        tableDetailsMovie.delegate = self
        tableDetailsMovie.dataSource = self
        registerCells()
    }
    
    private func registerCells(){
        tableDetailsMovie.register(DetailTableViewCell.nib(), forCellReuseIdentifier: DetailTableViewCell.identifier)
        tableDetailsMovie.register(CastMovieTableViewCell.nib(), forCellReuseIdentifier: CastMovieTableViewCell.identifier)
        tableDetailsMovie.register(MoviesCategoriesTableViewCell.nib(), forCellReuseIdentifier: MoviesCategoriesTableViewCell.identifier)
    }
    
    private func bind(){
        viewModel.refreshData = { [weak self] () in DispatchQueue.main.async {
            self?.tableDetailsMovie?.reloadData()
            }
        }
    }
    
    func configureView(for movie: Movie){
        self.movie = movie
        guard let movieID = movie.id else { return}
        viewModel.loadCast(for: movieID)
        viewModel.loadSimilar(for: movieID)
        viewModel.loadRecommended(for: movieID)
        viewModel.loadReviews(for: movieID)
        bind()
    }
}

extension DetailMovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionInTable = indexPath.section
        switch sectionInTable{
        case 0:
            let cell = tableDetailsMovie.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as! DetailTableViewCell
            cell.configureCell(movie: movie)
            return cell
        case 1:
            let cell = tableDetailsMovie.dequeueReusableCell(withIdentifier: CastMovieTableViewCell.identifier, for: indexPath) as! CastMovieTableViewCell
            cell.configure(with: viewModel.cast)
            return cell
        case 2:
            let cell = tableDetailsMovie.dequeueReusableCell(withIdentifier: MoviesCategoriesTableViewCell.identifier, for: indexPath) as! MoviesCategoriesTableViewCell
            cell.MovieCategoryNameLabel.text = "Titulos similares"
            cell.configure(with: viewModel.moviesSimilar)
            return cell
        case 3:
            let cell = tableDetailsMovie.dequeueReusableCell(withIdentifier: MoviesCategoriesTableViewCell.identifier, for: indexPath) as! MoviesCategoriesTableViewCell
            cell.MovieCategoryNameLabel.text = "Recomendaciones"
            cell.configure(with: viewModel.moviesRecommended)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
