//
//  MovieDetailsViewController.swift
//  Film
//
//  Created by cuongnh5 on 23/10/2023.
//

import UIKit
import SDWebImage

class MovieDetailsViewController: UIViewController {
    var viewModel: MovieDetailsViewModelProtocol?
    var movie: Movie?
    
    private let boundScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator  = true
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let middleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let backdropImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 26)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let popularityLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let synopsisLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        configureUI()
        viewModel?.getGenre { [weak self] in
            self?.setupData()
        }
    }
    
    func setupData() {
        if let movie = movie, let viewModel = viewModel {
            
//            let genreIDs: [Int] = movie.genreIds
            guard let genreIDs = movie.genreIds else {
                return
            }
            let genreNames: [String] = viewModel.genres
                .filter { genre in genreIDs.contains(genre.id) }
                .compactMap { $0.name }

            let genreString = "Genre: " + genreNames.joined(separator: ", ")
            
            DispatchQueue.main.async { [weak self] in
                self?.titleLabel.text = movie.originalTitle
                self?.genreLabel.text = genreString
                self?.languageLabel.text = "Language:  \(movie.originalLanguage ?? "")"
                self?.popularityLabel.text = "Popularity: \(movie.popularity)"
                self?.synopsisLabel.text = movie.overview
            }
            
            guard let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdropPath!)") else {
                return
            }
            
            guard let posterUrl = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath!)") else {
                return
            }
            self.backdropImage.sd_setImage(with: backdropUrl, completed: nil)
            self.posterImage.sd_setImage(with: posterUrl, completed: nil)
        }
    }
    
    func setViewModel(viewModel: MovieDetailsViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    func configureUI() {
        view.addSubview(boundScrollView)
        NSLayoutConstraint.activate([
            boundScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            boundScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boundScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            boundScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        boundScrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: boundScrollView.contentLayoutGuide.topAnchor),
            contentView.leftAnchor.constraint(equalTo: boundScrollView.contentLayoutGuide.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: boundScrollView.contentLayoutGuide.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: boundScrollView.contentLayoutGuide.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: boundScrollView.centerXAnchor)
        ])
        
        configureTopView()
        configureMiddle()
        configureBottomView()
        
        boundScrollView.contentSize = CGSize(width: contentView.frame.width, height: contentView.frame.height)

    }
    
    func configureTopView() {
        contentView.addSubview(topView)
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150)
        ])
        
        topView.addSubview(backdropImage)
        NSLayoutConstraint.activate([
            backdropImage.topAnchor.constraint(equalTo: topView.topAnchor),
            backdropImage.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            backdropImage.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            backdropImage.bottomAnchor.constraint(equalTo: topView.bottomAnchor)
        ])
    }
    
    func configureMiddle() {
        contentView.addSubview(middleView)
        NSLayoutConstraint.activate([
            middleView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -70),
            middleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            middleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            middleView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)
        ])
        
        middleView.addSubview(posterImage)
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: middleView.topAnchor),
            posterImage.leadingAnchor.constraint(equalTo: middleView.leadingAnchor, constant: 20),
            posterImage.heightAnchor.constraint(equalToConstant: 200),
            posterImage.widthAnchor.constraint(equalTo: posterImage.heightAnchor, multiplier: 500/750)
        ])
        
        configureverticalStackView()
    }
    
    func configureverticalStackView() {
        middleView.addSubview(verticalStackView)
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: posterImage.topAnchor, constant: 10),
            verticalStackView.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 20),
            verticalStackView.trailingAnchor.constraint(equalTo: middleView.trailingAnchor, constant: -20),
            verticalStackView.bottomAnchor.constraint(equalTo: posterImage.bottomAnchor)
        ])
        
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(genreLabel)
        verticalStackView.addArrangedSubview(languageLabel)
        verticalStackView.addArrangedSubview(popularityLabel)
    }
    
    func configureBottomView() {
        contentView.addSubview(bottomView)
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: middleView.bottomAnchor, constant: 20),
            bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        bottomView.addSubview(synopsisLabel)
        NSLayoutConstraint.activate([
            synopsisLabel.topAnchor.constraint(equalTo: bottomView.topAnchor),
            synopsisLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            synopsisLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20),
            synopsisLabel.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor)
        ])
    }
}
