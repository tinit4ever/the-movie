//
//  HomeViewController.swift
//  Film
//
//  Created by cuongnh5 on 20/10/2023.
//

import UIKit

class HomeViewController: UIViewController {
    var viewModel: HomeControllerViewModelProtocol?
    
    var numberOfColumns: CGFloat = 3
    static let space: CGFloat = 10
    
    func setViewModel(viewModel: HomeControllerViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    // Create UI
    private let filmCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100, height: 150)
        layout.minimumLineSpacing = space
        layout.minimumInteritemSpacing = space
        layout.sectionInset = UIEdgeInsets(top: layout.minimumLineSpacing, left: layout.minimumLineSpacing, bottom: layout.minimumLineSpacing, right: layout.minimumLineSpacing)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FilmCollectionViewCell.self, forCellWithReuseIdentifier: FilmCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        viewModel?.getMovie(onSuccess: {
            DispatchQueue.main.async {
                self.filmCollectionView.reloadData()
            }
        })
        
        configureNavController()
        configureCollectionView()
    }
    
    // ConfigUI
    func configureNavController() {
        navigationItem.title = "HOME"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logoutButtonTapped))
    }
    
    func configureCollectionView() {
        view.addSubview(filmCollectionView)
        filmCollectionView.delegate = self
        filmCollectionView.dataSource = self
        NSLayoutConstraint.activate([
            filmCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filmCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            filmCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            filmCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // Catch Action
    @objc
    func logoutButtonTapped() {
        let viewController = ViewController()
        DispatchQueue.main.async {
            self.navigationController?.setViewControllers([viewController], animated: true)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = viewModel?.movies[indexPath.row] else {
            return
        }
        let movieDetailsViewController = MovieDetailsViewController()
        movieDetailsViewController.setViewModel(viewModel: MovieDetailsViewModel(baseFetcher: BaseFetcher()))
        movieDetailsViewController.movie = movie
        
        navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.movies.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmCollectionViewCell.identifier, for: indexPath) as? FilmCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let movie = viewModel?.movies[indexPath.row] else {
            return UICollectionViewCell()
        }
        
        cell.confiure(with: movie)
        
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewWidth = collectionView.frame.width
        var cellWidth: CGFloat = (collectionViewWidth - (10 * (numberOfColumns + 1))) / numberOfColumns
        cellWidth = floor(cellWidth)
        let cellHeight: CGFloat = cellWidth * (3.0 / 2.0)
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
