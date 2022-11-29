//
//  MovieHomeTabBarViewController.swift
//  BAZProject
//
//  Created by 1028092 on 28/11/22.
//
import Foundation
import UIKit

final class MovieHomeTabBarViewController: UIViewController, MovieHomeViewProtocol {    
    
    
    var presenter: MovieHomeTabBarPresenterProtocol?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter?.setViewsControllerBar(frame: self)
        
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
