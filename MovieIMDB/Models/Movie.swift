//
//  Movie.swift
//  MovieIMDB
//
//  Created by Thiago M Faria on 01/12/23.
// To parse the JSON, add this file to your project and do:
//
//   let movies = try? JSONDecoder().decode(Movies.self, from: jsonData)

import Foundation

struct Movie: Codable, Identifiable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case overview
        case popularity
        case id
        case title
        case video
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension Movie {
    static func mock() -> Movie {
        self.init(adult: true,
                  backdropPath: "/tmU7GeKVybMWFButWEGl2M4GeiP.jpg",
                  genreIDS: [18,
                             80],
                  id: 238,
                  originalLanguage: "en",
                  originalTitle: "The Godfather",
                  overview: "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.",
                  popularity: 170.318,
                  posterPath: "/3bhkrj58Vtu7enYsRolD1fZdja1.jpg",
                  releaseDate: "1972-03-14",
                  title: "The Godfather",
                  video: false,
                  voteAverage: 8.709,
                  voteCount: 19086)
        
    }
}
