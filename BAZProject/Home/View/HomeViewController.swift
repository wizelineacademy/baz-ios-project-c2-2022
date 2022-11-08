//
//  HomeViewController.swift
//  BAZProject
//
//  Created by Alan Emiliano Ramirez Ayala on 20/10/22.
//

import UIKit

class HomeViewController: UIViewController, PrincipalView {
     
    @IBOutlet weak var segmentControl: UISegmentedControl! {
        didSet {
            segmentControl.setTitle("Trending", forSegmentAt: 0)
            segmentControl.setTitle("Now Paying", forSegmentAt: 1)
            segmentControl.setTitle("Popular", forSegmentAt: 2)
            segmentControl.setTitle("Top Rated", forSegmentAt: 3)
            segmentControl.setTitle("Up Coming", forSegmentAt: 4)
        }
    }
    @IBOutlet weak var tableViewMovies: UITableView! {
        didSet {
            let nib = UINib(nibName: "MovieCell", bundle: nil)
            tableViewMovies.register(nib, forCellReuseIdentifier: "MovieCell")
            tableViewMovies.dataSource = self
            tableViewMovies.delegate = self
            tableViewMovies.reloadData()
        }
    }
    let homeViewModel = ViewModelMovie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateView()
        refreshData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func showInfo(_ sender: Any) {
        self.homeViewModel.changeInfoByIndex(segmentControl.selectedSegmentIndex)
    }
    
    func configurateView() {
        homeViewModel.movieApiDelegate = MovieAPI()
        homeViewModel.getAllMovies()
    }
    
    func refreshData() {
        homeViewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableViewMovies.reloadData()
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.homeViewModel.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableViewMovies.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieTableViewCell
        cell.setUpSkeleton()
        cell.titleMovie.showAnimatedGradientSkeleton()
        cell.qualificationMovie.showAnimatedGradientSkeleton()
        cell.imageViewMovie.showAnimatedGradientSkeleton()
        cell.originalTitleMovie.showAnimatedGradientSkeleton()
        DispatchQueue.main.asyncAfter(deadline: .now()) { [self] in
            cell.originalTitleMovie.hideSkeleton()
            cell.titleMovie.hideSkeleton()
            cell.qualificationMovie.hideSkeleton()
            cell.imageViewMovie.hideSkeleton()
            cell.movieModel = homeViewModel.getInfoIndex(indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.detailViewModel.dataArray = homeViewModel.dataArray[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
//        present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
