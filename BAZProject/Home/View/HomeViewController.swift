//
//  HomeViewController.swift
//  BAZProject
//
//  Created by Alan Emiliano Ramirez Ayala on 20/10/22.
//

import UIKit

final class HomeViewController: UIViewController, PrincipalView {
    
    var movies: Int = 0
     
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
    
    @IBOutlet weak var movieNotification: UIButton!
    
    let homeViewModel = ViewModelMovie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateView()
        refreshData()
        NotificationCenter.default.addObserver(self, selector: #selector(changeValueOfNotification(_:)), name: NSNotification.Name(rawValue: "notificationValue"), object: nil)
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
    
    @IBAction func showDetailOfNotification(_ sender: Any) {
        self.present(GenericFunctions.sendAlert("Tus películas", "Estas son las peliculas consultadas hasta ahora: \(movies)"), animated: true, completion: nil)
    }
    
    @objc func changeValueOfNotification(_ notification: Notification) {
        movies += 1
        movieNotification.tintColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        movieNotification.setTitle("\(movies)", for: .normal)
    }

}
