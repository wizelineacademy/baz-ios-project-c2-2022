//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UIViewController {
    @IBOutlet weak var segCategories: UISegmentedControl!
    @IBOutlet weak var lblMovies: UILabel!
    @IBOutlet weak var tblMovie: UITableView! {
        didSet{
            tblMovie.delegate = self
            tblMovie.dataSource = self
            registerNibs()
        }
    }
    
    // MARK: - Properties
    let movieApi = MovieAPI()
    let identifier = "TrendingTableViewCell"
    var movie: [Movie] = []
    var movieVisited : Int = 0
    
    
    //MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenterHelper.subscribeToNotification(self, with: #selector(notificationReceived), name: NSNotification.Name(rawValue: "TrendingTable.TappedCell.Notification"))
        movieVisited = 0
        getMovie()
        
    }
    
    @objc private func notificationReceived(_ notification: NSNotification) {
        guard let model = notification.userInfo?["TappedTrending"] as? Bool else { return }
        if model {
        movieVisited += 1
        lblMovies.text = String(movieVisited)
        }
    }
    /// Register the custom cell to Trending
    private func registerNibs() {
        tblMovie.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    @IBAction func segCategories(_ sender: Any) {
        getMovie()
    }
    /// Makes a query to the service
    func getMovie() {
        movieApi.getMovies(categories: MovieSections(rawValue: segCategories.selectedSegmentIndex ) ?? .nowPlaying) { results in
            if let movie = results {
                self.movie = movie
                DispatchQueue.main.async {
                    self.tblMovie.reloadData()
                }
            }
        }
    }
}
// MARK: - TableView's DataSource
extension TrendingViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TrendingTableViewCell else{ return UITableViewCell() }
        cell.getInfoCell(movie: movie[indexPath.row] )
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenterHelper.myNotificationCenter.post(name: NSNotification.Name(rawValue: "TrendingTable.TappedCell.Notification"), object: nil, userInfo: ["TappedTrending": true])
        let vc = DetailViewController(nibName: "DetailViewController", bundle: Bundle(for: DetailViewController.self))
        vc.dataMovie = movie[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

