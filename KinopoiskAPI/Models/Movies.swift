//
//  Movies.swift
//  KinopoiskAPI
//
//  Created by Dmitriy Pavlov on 10.01.2023.
//

struct Movies: Decodable {
    let docs: [Doc]
    let pages: Int
}

struct Doc: Decodable {
    let poster: Poster
    let rating: Rating
    let id: Int
    let movieLength: Int?
    let name: String?
    let description: String?
    let year: Int
}

struct Poster: Decodable {
    let url: String
}

struct Rating: Decodable {
    let kp: Double
}
