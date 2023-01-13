//
//  MovieDetailViewController.swift
//  KinopoiskAPI
//
//  Created by Dmitriy Pavlov on 12.01.2023.
//

import Foundation
import UIKit
import WebKit

protocol MovieDetailViewProtocol: AnyObject {
    func setupUI()
    func setupCollectionView()
    func playVideo(videoUrl: String)
    func showSpinner()
    func removeSpinner()
}

final class MovieDetailViewController: UIViewController {
    
    var presenter: MovieDetailPresenterProtocol!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupConstraints()
        presenter.getMovieDetails()
        setupUI()
    }
    
    // MARK: - Private Views
    
    // MARK: - Constants
    
    private enum Constants {
        static let imageSize: CGSize = CGSize(width: 100, height: 500)
    }
    
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
    
    private let movieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let personRoleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let moviePosterImageView: UIImageView = {
       let imageView = UIImageView()
        return imageView
    }()
    
    private let movieLenghtStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let scrollView = UIScrollView()
    
    private let scrollViewContainer = UIView()
    
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let personCollectionView = PersonCollectionView()
    
    private let trailerVideoWebView = WKWebView()
    
}

private extension MovieDetailViewController {
    
    func configure() {
        view.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        view.add(scrollView)
        
        scrollView.add(scrollViewContainer)
        scrollViewContainer.addViews([moviePosterImageView, mainStackView, trailerVideoWebView])
        
        mainStackView.addArrangedSubviews([
            movieNameLabel,
            movieYearLabel,
            movieLenghtLabel,
            genreLabel,
            movieRatingLabel,
            movieDescriptionLabel,
            personRoleLabel,
            personCollectionView
        ])
        
        mainStackView.setCustomSpacing(32, after: movieRatingLabel)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollViewContainer.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        moviePosterImageView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview()
            $0.size.equalTo(Constants.imageSize)
        }
        
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(moviePosterImageView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        trailerVideoWebView.snp.makeConstraints {
            $0.top.equalTo(mainStackView.snp.bottom).offset(100)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(200)
        }
    }
}

extension MovieDetailViewController: MovieDetailViewProtocol {
    
    func setupUI() {
        movieNameLabel.text = presenter.movie.name
        movieYearLabel.text = Strings.Movies.movieYear + String(presenter.movie.year)
        movieRatingLabel.text = Strings.Movies.movieRating  + String(presenter.movie.rating.kp)
        
        let (hour, min) = (presenter.movie.movieLength ?? 0).convertMinutes()
        movieLenghtLabel.text = Strings.Movies.movieLenght + "\(hour) ч \(min) мин"
        
        movieDescriptionLabel.text = presenter.movie.description ?? ""
        moviePosterImageView.setImageFromUrl(imageUrl: presenter.movie.poster.url)
        
        personRoleLabel.text = Strings.Movies.personRole
        personRoleLabel.isHidden = presenter.movieDetails?.persons.isEmpty ?? true
        personCollectionView.isHidden = presenter.movieDetails?.persons.isEmpty ?? true
        
        var arrayGenre = [String]()
        for i in 0...(presenter.movieDetails?.genres.count ?? 1) - 1 {
            arrayGenre.append(presenter.movieDetails?.genres[i].name ?? "")
        }
        genreLabel.text = arrayGenre.joined(separator: " , ")
    }
    
    func setupCollectionView() {
        let persons = presenter.movieDetails?.persons ?? []
        personCollectionView.render(persons: persons)
    }
    
    func playVideo(videoUrl: String) {
        guard let videoURL = URL(string: videoUrl) else { return }
        trailerVideoWebView.configuration.mediaTypesRequiringUserActionForPlayback = .all
        trailerVideoWebView.load(URLRequest(url: videoURL))
    }
}
