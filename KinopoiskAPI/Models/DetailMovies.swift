//
//  DetailMovies.swift
//  KinopoiskAPI
//
//  Created by Dmitriy Pavlov on 10.01.2023.
//

struct MovieDetail: Decodable {
    let videos: Videos
    let genres: [Genres]
    let persons: [Persons]
}

struct Videos: Decodable {
    let trailers: [Trailer]
}

struct Trailer: Decodable {
    let url: String
}

struct Genres: Decodable {
    let name: String
}

struct Persons: Decodable {
    let name: String
    let description: String?
    let enProfession: String
    let photo: String
}
