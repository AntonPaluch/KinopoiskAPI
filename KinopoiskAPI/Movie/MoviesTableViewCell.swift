//
//  MoviesTableViewCell.swift
//  KinopoiskAPI
//
//  Created by Dmitriy Pavlov on 12.01.2023.
//

import UIKit
import SnapKit

final class MoviesTableViewCell: UITableViewCell {
        
    // MARK: - Constants
    
    private enum Constants {
        static let imageSize: CGSize = CGSize(width: 100, height: 135)
        

    }
    
    
    // MARK: - Private Views
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let movieYearLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let movieRatingLabel: UILabel = {
    let label = UILabel()
    return label
    }()
        
    private let movieIconLenghtView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "clock.fill"), highlightedImage: .none)
        imageView.tintColor = .gray
        return imageView
    }()
    
    private let movieLenghtLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let moviePosterImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let movieLenghtStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configure()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods

private extension MoviesTableViewCell {
    
    func configure() {
        selectionStyle = .none
        moviePosterImageView.backgroundColor = .lightGray
        
        movieLenghtStackView.addArrangedSubviews([
            movieIconLenghtView,
            movieLenghtLabel
        ])
    
        contentView.addViews([
            movieNameLabel,
            movieYearLabel,
            movieRatingLabel,
            moviePosterImageView,
            movieLenghtStackView
        ])
    }
    
    func setupConstraints() {
        
        moviePosterImageView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.top.bottom.equalToSuperview().inset(8)
            $0.size.equalTo(Constants.imageSize)
        }
        
        movieNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.left.equalTo(moviePosterImageView.snp.right).offset(12)
            $0.right.equalToSuperview().inset(12)
        }
        
        movieYearLabel.snp.makeConstraints {
            $0.top.equalTo(movieNameLabel.snp.bottom).offset(4)
            $0.left.equalTo(moviePosterImageView.snp.right).offset(12)
            $0.right.equalToSuperview().inset(12)
        }
        
        movieRatingLabel.snp.makeConstraints {
            $0.top.equalTo(movieYearLabel.snp.bottom).offset(4)
            $0.left.equalTo(moviePosterImageView.snp.right).offset(12)
            $0.right.equalToSuperview().inset(12)
        }
        
        movieLenghtStackView.snp.makeConstraints {
            $0.top.equalTo(movieRatingLabel.snp.bottom).offset(4)
            $0.left.equalTo(moviePosterImageView.snp.right).offset(12)
        }
    }
}

// MARK: - Public Methods

extension MoviesTableViewCell {
    
    func render(_ movieData: Doc) {
        movieNameLabel.text = movieData.name
        movieYearLabel.text = "Год выпуска: " + String(movieData.year)
        movieRatingLabel.text = "Рейтинг кинопоиска: " + String(movieData.rating.kp)
        let (hour, min) = (movieData.movieLength ?? 10).convertMinutes()
        movieLenghtLabel.text = "\(hour) ч \(min) мин"
        moviePosterImageView.setImageFromUrl(imageUrl: movieData.poster.url)
        }
}



