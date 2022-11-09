//
//  MoviesCategoriesViewController.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 03/11/22.
//

import UIKit

final class MoviesCategoriesViewController: UIViewController {
    
    private let itemsPerRow: CGFloat = 2.0
    private var movies: [Movie] = []
    private let movieApi = MovieAPI()
    
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var pickerSelector: UIPickerView!
    @IBOutlet weak var collectionMovies: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let indicatorAnimating = indicator
        indicatorAnimating.startAnimating()
        movieApi.getMovies(by: .trending, completion: { result in
            switch result{
            case .success(let movies):
                self.movies = movies.movies
                DispatchQueue.main.async {
                    if self.movies.count > 0 {
                        self.collectionMovies.reloadData()
                        indicatorAnimating.stopAnimating()
                    } else {
                        self.showError(with: .arrayEmpty)
                        indicatorAnimating.stopAnimating()
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    indicatorAnimating.stopAnimating()
                    guard let error = error as? APIError else {return}
                    self.showError(with: error)
                }
            }
        })
        NotificationCenter.default.addObserver(self, selector: #selector(moviesCount(with:)), name: NSNotification.Name(rawValue: "contadorToVCCategory"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Movies"
        setupElements()
        pickerSelector.customPicker()
        btnSearch.shakeButton()
    }
    
    private func setupElements() {
        self.pickerSelector.dataSource = self
        self.pickerSelector.delegate = self
        self.collectionMovies.delegate = self
        self.collectionMovies.dataSource = self
        self.collectionMovies.register(UINib(nibName: MoviesCategoryCollectionViewCell.nameCell, bundle: nil), forCellWithReuseIdentifier: MoviesCategoryCollectionViewCell.identifier)
    }
    
    private func changePickerSelected(_ value: Int) {
        let indicatorAnimating = indicator
        indicatorAnimating.startAnimating()
        movies.removeAll()
        movieApi.getMovies(by: CategoryFilterMovie(rawValue: value) ?? .nowPlaying) { resultado in
            switch resultado {
            case .success(let result):
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)){
                    self.movies = result.movies
                    self.collectionMovies.reloadData()
                    indicatorAnimating.stopAnimating()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    guard let error = error as? APIError else {return}
                    self.showError(with: error)
                    indicatorAnimating.stopAnimating()
                }
            }
        }
    }
    
    @objc private func moviesCount(with notification: Notification) {
        guard let userInfo = notification.object as? [String:Any ] else { return }
        print(userInfo)
    }
    
    @IBAction private func tapSearch() {
        guard let vc = SearchMovieViewController.instantiate() else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MoviesCategoriesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionMovies.dequeueReusableCell(withReuseIdentifier: MoviesCategoryCollectionViewCell.identifier, for: indexPath) as? MoviesCategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setUpCell(movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailsMovieRouter.createModuleDetailsMovie(with: movies[indexPath.row], from: .moviesCategory)
        self.present(vc, animated: true)
    }
    
    
}

extension MoviesCategoriesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = 20.0 * (itemsPerRow + 1)
        let availableWidth = self.collectionMovies.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem * 1.7)
    }
}

extension MoviesCategoriesViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        changePickerSelected(row)
    }
}

extension MoviesCategoriesViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CategoryFilterMovie(rawValue: row)?.title
    }
}
