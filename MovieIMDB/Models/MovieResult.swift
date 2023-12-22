//
//  TopRated.swift
//  MovieIMDB
//
//  Created by Thiago M Faria on 01/12/23.
//
import Foundation

struct MovieResult: Codable {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
