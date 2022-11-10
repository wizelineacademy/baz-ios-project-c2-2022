//
//  HomeViewController.swift
//  BAZProject
//
//  Created by Alan Emiliano Ramirez Ayala on 20/10/22.
//

import UIKit

class HomeViewController: UIViewController, PrincipalView {
    
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
        sendAlert("Tus películas", "Estas son las peliculas consultadas hasta ahora: \(movies)")
    }
    
    @objc func changeValueOfNotification(_ notification: Notification) {
        movies += 1
        movieNotification.tintColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        movieNotification.setTitle("\(movies)", for: .normal)
    }
    
    func sendAlert(_ title: String,_ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
