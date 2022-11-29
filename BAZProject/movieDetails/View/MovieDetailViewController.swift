//
//  MovieDetailViewController.swift
//  BAZProject
//
//  Created by 1028092 on 11/11/22.
//

import Foundation
import UIKit

final class MovieDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MovieDetailViewProtocol {
    var presenter: MovieDetailPresenterInputProtocol?
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 30
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 25, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView.detailImage()
    }()
    
    let subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.font = .systemFont(ofSize: 18, weight: .regular)
        return subtitleLabel.styleLabel()
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        return textView.detailTextView()
    }()
    
    let reviewsLabel: UILabel = {
        let reviewsLabel = UILabel()
        reviewsLabel.font = .systemFont(ofSize: 18, weight: .regular)
        reviewsLabel.translatesAutoresizingMaskIntoConstraints = false
        return reviewsLabel
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HeaderViewCell.nib(), forHeaderFooterViewReuseIdentifier: HeaderViewCell.identifier)
        tableView.register(ReviewTableViewCell.nib(), forCellReuseIdentifier: ReviewTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let movieDetailData: Movie
    
    init(movieDetailData: Movie) {
        self.movieDetailData = movieDetailData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        addSubViews()
        setContraints()
        configure(movieData: movieDetailData)
    }
    /// This functiont receive parameter configure
    /// - parameters
    ///     -movieData: is get Movie Detail
    private func configure(movieData: Movie) {
        presenter?.callServiceApis(1, idMovie: String(movieData.id))
        imageView.loadFromNetwork(movieData.backdrop)
        titleLabel.text = movieData.title
        subtitleLabel.text = "Descripción"
        textView.text = movieData.overview
        title = movieData.title
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    /// This function dot not receive parameter addSubViews
    /// - parameters
    private func addSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollStackViewContainer)
        scrollStackViewContainer.addArrangedSubview(titleLabel)
        scrollStackViewContainer.addArrangedSubview(imageView)
        scrollStackViewContainer.addArrangedSubview(subtitleLabel)
        scrollStackViewContainer.addArrangedSubview(textView)
        scrollStackViewContainer.addArrangedSubview(tableView)
    }
    /// This function dot not receive parameter reloadReviewsDetail
    /// - parameters
    func reloadReviewsDetail() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
