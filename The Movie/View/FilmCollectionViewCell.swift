//
//  FilmCollectionViewCell.swift
//  Film
//
//  Created by cuongnh5 on 20/10/2023.
//

import UIKit
import SDWebImage

class FilmCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "FilmCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let detailView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .lightGray
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Sample Title"
        label.textColor = .white
        
        label.font = label.font.withSize(14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
//        label.minimumContentSizeCategory = 12
//        label.minimumScaleFactor.isEqual(to: 10)
        
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let popularityLabel: UILabel = {
        let label = UILabel()

        label.text = "Popular: 99999"
        label.textColor = .white
        label.font = label.font.withSize(10)
        label.numberOfLines = 0
        
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .systemMint
        self.contentView.layer.cornerRadius = 10
        configureUI()
    }
    
    func configureUI() {
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        configureDetailView()
    }
    
    func configureDetailView() {
        contentView.addSubview(detailView)
        NSLayoutConstraint.activate([
            detailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            detailView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            detailView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40)
        ])

        detailView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: detailView.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -10),
            titleLabel.centerXAnchor.constraint(equalTo: detailView.centerXAnchor),
        ])
        
        detailView.addSubview(popularityLabel)
        NSLayoutConstraint.activate([
            popularityLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            popularityLabel.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 10),
            popularityLabel.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -10),
            popularityLabel.bottomAnchor.constraint(equalTo: detailView.bottomAnchor, constant: -5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func confiure(with movie: Movie) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path!)") else {
            return
        }
        imageView.sd_setImage(with: url, completed: nil)
        titleLabel.text = movie.original_title
        popularityLabel.text = "Popular: \(movie.popularity)"
    }
}
