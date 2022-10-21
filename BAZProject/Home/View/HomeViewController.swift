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
        switch segmentControl.selectedSegmentIndex {
        case 0:
            viewModel.changeDataToShow(.Trendig)
        case 1:
            viewModel.changeDataToShow(.NowPlaying)
        case 2:
            viewModel.changeDataToShow(.Popular)
        case 3:
            viewModel.changeDataToShow(.TopRated)
        default:
            viewModel.changeDataToShow(.UpComing)
            
        }
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableViewMovies.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieTableViewCell
        let imageMovie = UIImage(data: viewModel.getImage(urlImage: viewModel.dataArray[indexPath.row].poster_path)) ?? UIImage(named: "poster")
        cell.configure(titulo: viewModel.dataArray[indexPath.row].title, originalTitle: viewModel.dataArray[indexPath.row].original_title, calificacion: viewModel.dataArray[indexPath.row].vote_average, image: imageMovie ?? UIImage())
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        var config = UIListContentConfiguration.cell()
//        config.text = viewModel.dataArray[indexPath.row].title
//        config.image = UIImage(data: viewModel.getImage(urlImage: viewModel.dataArray[indexPath.row].poster_path))
//        cell.contentConfiguration = config
//    }
}
