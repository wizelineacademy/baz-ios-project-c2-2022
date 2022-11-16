//
//  RencentlyMoviesViewController.swift
//  BAZProject
//
//  Created by Sarahi Pérez Rosas on 16/11/22.
//

import UIKit

class RencentlyMoviesViewController: UIViewController {

    @IBOutlet weak var tableRecentlyMovies: UITableView!
    var movies : [Movie] = []
    var countMovies: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        notificationRecentlyMovies()
    }
    
    private func configureView(){
        tableRecentlyMovies.delegate = self
        tableRecentlyMovies.dataSource = self
        tableRecentlyMovies.register(SearchTableViewCell.nib(), forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
    
    func notificationRecentlyMovies() {
        NotificationCenterHelper.subscribeToNotification(self, with: #selector(notificationReceived), name: Notification.Name(rawValue: "detailMovieCell.Notification"))
    }
    
    @objc func notificationReceived(_ notification: NSNotification) {
        guard let movie = notification.userInfo?["detailMovie"] as? Movie else {return}
        movies = movies.filter({$0.id != movie.id})
        movies.append(movie)
        countMovies+=1
        createBadge(countMovies)
    }
    
    func createBadge(_ counterMovies: Int){
        let tabBar = self.tabBarController!.tabBar
        let add = tabBar.items![3]
        add.badgeColor = counterMovies > 0 ? UIColor.red : UIColor.clear
        add.badgeValue = counterMovies > 0 ? "\(counterMovies)" : ""
    }
}

extension RencentlyMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableRecentlyMovies.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        let movie = movies[indexPath.row]
        cell.lblTitleMovie.text = movie.title
        if let posterPath = movie.posterPath{
            cell.imgPosterPath.setMovieImage(nameImage: posterPath)
        }
        return cell
    }
    
    
}
