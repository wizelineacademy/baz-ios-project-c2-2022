//
//  ProtocolsMovie.swift
//  BAZProject
//
//  Created by Alan Emiliano Ramirez Ayala on 02/11/22.
//

import UIKit

protocol PrincipalView: GenericView{
    func refreshData()
}
 
protocol GenericView {
    func configurateView()
}

protocol GenericViewModel {
    var dataArray: [Movie] {get set}
    func getImage(urlImage: String) -> Data
}

protocol PrincipalViewModel: GenericViewModel {
    var movieApi: MovieAPI {get set}
    func getInfo(_ api: MovieFeed)
}

protocol GenericCellMovie {
    func setUpSkeleton()
    func configure()
}
