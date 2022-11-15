//
//  RecentlySeenViewController.swift
//  BAZProject
//
//  Created by mvazquezl on 14/11/22.
//

import UIKit

class RecentlySeenTableViewController: UITableViewController {
    
    @IBOutlet weak var tblRecentlyMovies: UITableView!
    
    //MARK: Properties
    var recentlyMovies: [InfoMovies] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tblRecentlyMovies.reloadData()
            }
        }
    }
    var countMovies: Int = 0
    
    //MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        instanceFromNib()
        notificationRecentlyMovies()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        countMovies = 0
        createBadge(0)
    }
    
    /// Add an entry to the notification center
    func notificationRecentlyMovies() {
        NotificationCenterHelper.subscribeToNotification(self, with: #selector(notificationReceived), name: Notification.Name(rawValue: "detailMovieCell.Notification"))
    }
    
    /// - Parameter notification: instance to acceso to parameters of notification
    @objc func notificationReceived(_ notification: NSNotification) {
        guard let movie = notification.userInfo?["detailMovie"] as? InfoMovies else {return}
        recentlyMovies = recentlyMovies.filter({$0.id != movie.id})
        recentlyMovies.append(movie)
        countMovies+=1
        createBadge(countMovies)
        self.basicAlert(title: "Visto Recientemente", message: "Pelicula\(movie.title ?? "")")
    }
    
    func createBadge(_ contadorMovies: Int){
        let tabBar = self.tabBarController!.tabBar
        let add = tabBar.items![2]
        add.badgeColor = contadorMovies > 0 ? UIColor.red : UIColor.white.withAlphaComponent(0.8)
        add.badgeValue = contadorMovies > 0 ? "\(contadorMovies)" : ""
    }
    
    //MARK: private methods
    private func instanceFromNib() {
        tblRecentlyMovies.register(UINib(nibName: "ContentMoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentMoviesTableViewCell")
    }
}

// MARK: - TableView's DataSource

extension RecentlySeenTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentlyMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContentMoviesTableViewCell", for: indexPath) as? ContentMoviesTableViewCell else {
            return UITableViewCell()
        }
        cell.showDetailsMovies(movie: recentlyMovies[indexPath.row])
        tblRecentlyMovies.separatorColor = .none
        return cell
    }
}
