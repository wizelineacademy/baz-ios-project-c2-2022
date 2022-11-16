//
//  HomeViewControllerExtension.swift
//  BAZProject
//
//  Created by Alan Emiliano Ramirez Ayala on 14/11/22.
//

import UIKit

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
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
