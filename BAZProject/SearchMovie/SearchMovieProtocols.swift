//
//  SearchMovieProtocols.swift
//  BAZProject
//
//  Created 1030364 on 17/10/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

// MARK: Wireframe -
protocol SearchMovieWireframeProtocol: AnyObject {

}
// MARK: Presenter -
protocol SearchMoviePresenterProtocol: AnyObject {

}

// MARK: Interactor -
protocol SearchMovieInteractorProtocol: AnyObject {

  var presenter: SearchMoviePresenterProtocol? { get set }
}

// MARK: View -
protocol SearchMovieViewProtocol: AnyObject {

  var presenter: SearchMoviePresenterProtocol? { get set }
}
