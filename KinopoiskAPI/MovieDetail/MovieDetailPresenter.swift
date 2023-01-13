//
//  MovieDetailPresenter.swift
//  KinopoiskAPI
//
//  Created by Dmitriy Pavlov on 12.01.2023.
//

import Foundation

protocol MovieDetailPresenterProtocol: AnyObject {
    init(networkService: NetworkServiceProtocol, movie: Doc)
    var movie: Doc { get }
    var movieDetails: MovieDetails? { get }
    func getMovieDetails()
}

final class MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    var movie: Doc
    var movieDetails: MovieDetails?
    
    weak var view: MovieDetailViewProtocol!
    
    private let networkService: NetworkServiceProtocol
    
    required init(networkService: NetworkServiceProtocol, movie: Doc) {
        self.networkService = networkService
        self.movie = movie
    }
    
    func getMovieDetails() {
        self.view.showSpinner()
        networkService.getMovieDetails(id: movie.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movie):
                self.movieDetails = movie
                self.view.setupUI()
                self.view.setupCollectionView()
                if let video = movie.videos.trailers.first?.url {
                    self.view.playVideo(videoUrl: (video))
                }
            case .failure(let error):
                print(error)
            }
            self.view.removeSpinner()
        }
    }
}
