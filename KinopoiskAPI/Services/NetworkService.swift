//
//  NetworkService.swift
//  KinopoiskAPI
//
//  Created by Dmitriy Pavlov on 10.01.2023.
//

import Foundation
import Moya

protocol NetworkServiceProtocol {
    func getBestMovies(page: Int, completion: @escaping (Result<Movies, Error>) -> Void)
    func getNewMovies(page: Int, completion: @escaping (Result<Movies, Error>) -> Void)
    func getMovieDetails(id: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void)
    func getSearchMovies(name: String, completion: @escaping (Result<Movies, Error>) -> Void)
}
    
final class NetworkService: NetworkServiceProtocol {
    
    var moviesProvider = MoyaProvider<MoviesService>()
    
    private func getJSONData<T:Decodable> (
        moviesProvider: MoyaProvider<MoviesService>,
        endpoint: MoviesService,
        completion: @escaping (Result<T, Error>) -> Void) {
            moviesProvider.request(endpoint) { result in
                switch result {
                case let .success(response):
                    do {
                        let json = try JSONDecoder().decode(T.self, from: response.data)
                        completion(.success(json))
                    } catch {
                        completion(.failure(error))
                    }
                case let .failure(error):
                    print(error)
                }
            }
        }
    
    func getBestMovies(page: Int, completion: @escaping (Result<Movies, Error>) -> Void) {
        getJSONData(moviesProvider: moviesProvider, endpoint: .bestMovies(page: page), completion: completion)
    }
    
    func getNewMovies(page: Int, completion: @escaping (Result<Movies, Error>) -> Void) {
        getJSONData(moviesProvider: moviesProvider, endpoint: .newMovies(page: page), completion: completion)
    }
    
    func getMovieDetails(id: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        getJSONData(moviesProvider: moviesProvider, endpoint: .detailMovie(id: id), completion: completion)
    }
    
    func getSearchMovies(name: String, completion: @escaping (Result<Movies, Error>) -> Void) {
        getJSONData(moviesProvider: moviesProvider, endpoint: .searchMovies(name: name), completion: completion)
    }
}
    


