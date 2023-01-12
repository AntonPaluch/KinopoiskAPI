//
//  URLEndpoint.swift
//  KinopoiskAPI
//
//  Created by Dmitriy Pavlov on 10.01.2023.
//

import Foundation
import Moya

enum MoviesService {
    case bestMovies(page: Int)
    case newMovies(page: Int)
    case searchMovies(name: String)
    case detailMovie(id: Int)
}

extension MoviesService: TargetType {
        
    var baseURL: URL {
        guard let url = URL(string: "https://api.kinopoisk.dev/")
        else { fatalError("url could not be configure") }
        return url
    }
    
    var path: String {
        return "movie"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        let token = "XSVFQ1H-BFZM73K-GNVXEQS-XDP320B"
        switch self {
        case .bestMovies(let page):
            return .requestParameters(
                parameters:
                    ["field": "typeNumber",
                     "search": "1",
                     "sortField": "votes.kp",
                     "sortType": "-1",
                     "limit": "20",
                     "page": "\(page)",
                     "token": token],
                encoding: URLEncoding.default
            )
            
        case .newMovies(let page):
            return .requestParameters(
                parameters:
                    ["field": ["rating.kp", "year", "typeNumber"],
                     "search": ["5-10", "2015-2022", "1"],
                     "sortField": ["year", "votes.kp"],
                     "sortType": ["-1", "-1"],
                     "limit": "21",
                     "page": "\(page)",
                     "token": token],
                encoding: URLEncoding.default
            )
        
        case .searchMovies(let name):
            return .requestParameters(
                parameters:
                    ["search": "\(name)",
                     "field": "name",
                     "isStrict": "false",
                     "token": token],
                encoding: URLEncoding.default
            )
                                                
        case .detailMovie(let id):
            return .requestParameters(
                parameters:
                    ["field": "id",
                     "search": "\(id)",
                     "token": token],
                encoding: URLEncoding.default
            )
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
