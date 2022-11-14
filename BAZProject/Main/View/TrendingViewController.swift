//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UIViewController, collectionMoviesDelegate {
    func presentDetailView(dataMovie: Movie) {
        let vc = DetailViewController(nibName: "DetailViewController",bundle: Bundle(for: DetailViewController.self))
        vc.dataMovie = dataMovie
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var tblMovie: UITableView! {
        didSet{
            tblMovie.delegate = self
            tblMovie.dataSource = self
            registerNibs()
        }
    }
    
    // MARK: - Properties
    let movieApi = MovieAPI()
    let cellcollection = cellCollection()
    let identifier = "TrendingTableViewCell"
    var dicMovies : [String:ResultsMovie]?
    private var movie: [Movie] = []
    public let identifierCollection = "CellCollection"
    
    
    //MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        movieApi.delegateDataMovie = self
        cellcollection.delegatePresentView = self
        NotificationCenterHelper.subscribeToNotification(self, with: #selector(notificationReceived), name: NSNotification.Name(rawValue: "TrendingTable.TappedCell.Notification"))
        getSections()
    }
    
    @objc private func notificationReceived(_ notification: NSNotification) {
        guard let model = notification.userInfo?["TappedTrending"] as? Movie else { return }
        print(model.title)
    }
    
    
    /// Register the custom cell to Trending
    private func registerNibs() {
        tblMovie.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func getSections() {
        self.movieApi.getMovies(category: MovieTableSections.trending.endpoint)
        self.movieApi.getMovies(category: MovieTableSections.nowPlaying.endpoint)
        self.movieApi.getMovies(category: MovieTableSections.upcoming.endpoint)
        self.movieApi.getMovies(category: MovieTableSections.topRated.endpoint)
        self.movieApi.getMovies(category: MovieTableSections.popular.endpoint)
    }
}

//MARK: Delegado Movie
extension TrendingViewController: MovieDataDelegate {
    func showDataMovies(dataMovie: ResultsMovie, category: String) {
        
        if ((dicMovies?.isEmpty) != nil) {
            dicMovies?[category] = dataMovie
            DispatchQueue.main.async {
                self.tblMovie.reloadData()
            }
        }else{
            self.dicMovies = [category : dataMovie]
        }
    }
}


// MARK: - TableView's DataSource

extension TrendingViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MovieTableSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: //Logo Movie
            return nil
        case 1: //Now Playing
            return MovieTableSections.nowPlaying.MovieListType
        case 2: //Popular
            return MovieTableSections.popular.MovieListType
        case 3: //Top Rated
            return MovieTableSections.topRated.MovieListType
        case 4: // Upcoming
            return MovieTableSections.upcoming.MovieListType
        case 5: //Trending
            return MovieTableSections.trending.MovieListType
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0, 1, 2, 3, 4:
            return 1
        case 5://Trending
            return dicMovies?[MovieTableSections.trending.endpoint]?.results.count ?? 0
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0://Logo Movie
            
            let cell:LogoMovieCell = tableView.dequeueReusableCell(withIdentifier: LogoMovieCell.identifier,for: indexPath) as! LogoMovieCell
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifierCollection , for: indexPath) as? cellCollection else{ return UITableViewCell() }
            if let movie = dicMovies?[MovieTableSections.nowPlaying.endpoint]?.results{
                cell.movie = movie
            }
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifierCollection , for: indexPath) as? cellCollection else{ return UITableViewCell() }
            if let movie = dicMovies?[MovieTableSections.popular.endpoint]?.results{
                cell.movie = movie
            }
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifierCollection , for: indexPath) as? cellCollection else{ return UITableViewCell() }
            if let movie = dicMovies?[MovieTableSections.topRated.endpoint]?.results{
                cell.movie = movie
            }
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifierCollection , for: indexPath) as? cellCollection else{ return UITableViewCell() }
            if let movie = dicMovies?[MovieTableSections.upcoming.endpoint]?.results{
                cell.movie = movie
            }
            return cell
            
        case 5://Trending
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TrendingTableViewCell else{ return UITableViewCell() }
            if let dataMovie = dicMovies?[MovieTableSections.trending.endpoint]{
                let info = dataMovie.results[indexPath.row]
                cell.getInfoCell(movie: info )
                
            }
            
            return cell
        default:
            let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        switch indexPath.section {
        case 5://Trending
            let vc = DetailViewController(nibName: "DetailViewController",
                                          bundle: Bundle(for: DetailViewController.self))
            if let dataMovie = dicMovies?[MovieTableSections.trending.endpoint]{
                vc.dataMovie = dataMovie.results[indexPath.row]
                NotificationCenterHelper.myNotificationCenter.post(name: NSNotification.Name(rawValue: "TrendingTable.TappedCell.Notification"), object: nil, userInfo: ["TappedTrending": dataMovie])
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
            }
            break
        default:
            break
        }
    }
}



