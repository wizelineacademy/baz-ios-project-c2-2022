//
//  FilterViewController.swift
//  BAZProject
//
//  Created by 1017143 on 19/10/22.
//

import Foundation
import UIKit

class MovieFilterViewController: UIViewController {
    @IBOutlet weak var categoriesTableView: UITableView!
    weak var filterDelegate: MovieFilterDelegate?
    // MARK: - Override viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    /// Close view controller presented
    ///
    /// - Parameter sender: Contains a Button object
    @IBAction func closeFilterAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /// Start request for new category selected
    ///
    /// - Parameter sender: Contains a Button object with references to cases ennum
    @objc func showCategoryAction(sender: UIButton) {
        self.filterDelegate?.getMoviesByCategory(category: CategoryMovieType.allCases[sender.tag])
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - TableView's DataSource
extension MovieFilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryMovieType.allCases.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = categoriesTableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell",
                                                                 for: indexPath) as? CategoryTableViewCell
        else {return UITableViewCell()}
        cell.showCategoryBtn.tag = indexPath.row
        cell.showCategoryBtn.setTitle(CategoryMovieType.allCases[indexPath.row].typeName, for: .normal)
        cell.showCategoryBtn.addTarget(self, action: #selector(showCategoryAction(sender:)), for: .touchUpInside)
        return cell
    }
}
