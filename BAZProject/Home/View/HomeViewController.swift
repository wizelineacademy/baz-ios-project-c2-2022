//
//  HomeViewController.swift
//  BAZProject
//
//  Created by Alan Emiliano Ramirez Ayala on 20/10/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableViewMovies: UITableView! {
        didSet {
            let nib = UINib(nibName: "MovieCell", bundle: nil)
            tableViewMovies.register(nib, forCellReuseIdentifier: "MovieCell")
            tableViewMovies.dataSource = self
            tableViewMovies.delegate = self
            tableViewMovies.reloadData()
        }
    }
    let viewModel = ViewModelMovie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateView()
        refreshData()
        configSegment()
    }
    private func configSegment() {
        segmentControl.setTitle("Trending", forSegmentAt: 0)
        segmentControl.setTitle("Now Paying", forSegmentAt: 1)
        segmentControl.setTitle("Popular", forSegmentAt: 2)
        segmentControl.setTitle("Top Rated", forSegmentAt: 3)
        segmentControl.setTitle("Up Coming", forSegmentAt: 4)
    }
    
    @IBAction func showInfo(_ sender: Any) {
        self.viewModel.changeInfoByIndex(segmentControl.selectedSegmentIndex)
    }
    
    private func configurateView() {
        viewModel.getAllMovies()
    }
    
    private func refreshData() {
        viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableViewMovies.reloadData()
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableViewMovies.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieTableViewCell
        cell.setUpSkeleton()
        cell.tituloMovie.showAnimatedGradientSkeleton()
        cell.calificacionMovie.showAnimatedGradientSkeleton()
        cell.imageViewMovie.showAnimatedGradientSkeleton()
        cell.originalTitleMovie.showAnimatedGradientSkeleton()
        DispatchQueue.main.asyncAfter(deadline: .now()) { [self] in
            cell.originalTitleMovie.hideSkeleton()
            cell.tituloMovie.hideSkeleton()
            cell.calificacionMovie.hideSkeleton()
            cell.imageViewMovie.hideSkeleton()
            let imageMovie = UIImage(data: self.viewModel.getImage(urlImage: viewModel.dataArray[indexPath.row].poster_path)) ?? UIImage(named: "poster")
            cell.configure(titulo: viewModel.dataArray[indexPath.row].title, originalTitle: viewModel.dataArray[indexPath.row].original_title, calificacion: viewModel.dataArray[indexPath.row].vote_average, image: imageMovie ?? UIImage())
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.viewModel.dataArray = viewModel.dataArray[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
