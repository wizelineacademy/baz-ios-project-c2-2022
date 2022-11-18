//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UIViewController {
    
    
    @IBOutlet var tblMovies: UITableView!
    @IBOutlet weak var segMovies: UISegmentedControl!
    
    //MARK: Properties
    let movieAPI = MovieAPI()
    var movieSelected: InfoMovies?
    private var countMoviesRecently: Int = 0
    var movies: [InfoMovies] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tblMovies.reloadData()
            }
        }
    }
    var recentMovies: RecentMovies = RecentMovies()
    
    //MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        instanceFromNib()
        getMovies()
        notificationRecentlyMovies()
    }
    
    //MARK: private methods
    private func instanceFromNib() {
        tblMovies.register(UINib(nibName: "ContentMoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentMoviesTableViewCell")
    }
    
    /// Add an entry to the notification center
    func notificationRecentlyMovies() {
        NotificationCenterHelper.subscribeToNotification(self, with: #selector(notificationReceived), name: Notification.Name(rawValue: "detailMovieCell.Notification"))
    }
    
    /// - Parameter notification: instance to acceso to parameters of notification
    @objc func notificationReceived(_ notification: NSNotification) {
        guard let movie = notification.userInfo?["detailMovie"] as? InfoMovies else {return}
        let duplicated = recentMovies.arrayMovies.contains { element in
            element.id == movie.id
        }
        if !duplicated {
            recentMovies.arrayMovies.append(movie)
            countMoviesRecently+=1
            createBadge(countMoviesRecently)
        }
    }
    
    /**
     create a badge to notify the user that they watched a movie
     -Parameter counterMovies: counter when entering the detail of the movies accumulating or resetting to 0 */
    func createBadge(_ counterMovies: Int){
        let tabBar = tabBarController!.tabBar
        let add = tabBar.items![2]
        add.badgeColor = counterMovies > 0 ? UIColor.red : UIColor.clear
        add.badgeValue = counterMovies > 0 ? "\(counterMovies)" : ""
    }
    
    private func getMovies() {
        self.movieAPI.getMovies(typeMovies: PathMovies.getPathForSegmentsOption(segMovies.selectedSegmentIndex)) { result in
            switch result {
            case .success(let movies):
                self.movies = movies
            case .failure(let error):
                debugPrint("Error\(error)")
                self.basicAlert(title: "Hubo algún problema", message: "\(error)")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsMovies" {
            let detailMovies = segue.destination as! DetailMovieViewController
            detailMovies.movie = movieSelected!
        }
    }
    
    
    @IBAction func segmentedChanged(_ sender: UISegmentedControl) {
        getMovies()
    }
}


// MARK: - TableView's DataSource and Delegate

extension TrendingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContentMoviesTableViewCell", for: indexPath) as? ContentMoviesTableViewCell else {
            return UITableViewCell()
        }
        cell.showDetailsMovies(movie: movies[indexPath.row])
        tblMovies.separatorColor = .none
        return cell
    }
    
    //Create notification when the user sees details of the movie
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         movieSelected = movies[indexPath.row]
         guard let movie = movieSelected else { return }
         NotificationCenterHelper.myNotificationCenter.post(name: Notification.Name(rawValue: "detailMovieCell.Notification"), object: nil, userInfo: ["detailMovie": movie])
        performSegue(withIdentifier: "detailsMovies", sender: nil)
    }
}

// MARK: - Delegate RecentSeenDataSource

extension TrendingViewController: RecentSeenDataSource {
    func badgeCleaned() {
        countMoviesRecently = 0
    }
    
    func getRecentMovies() -> RecentMovies { recentMovies }
}

