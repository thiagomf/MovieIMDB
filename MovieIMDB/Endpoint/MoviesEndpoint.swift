//
//  MoviesEndPoint.swift
//  MovieIMDB
//
//  Created by Thiago M Faria on 01/12/23.
//
import NetworkLayer
import Foundation

enum MoviesEndpoint {
    case topRated(page: Int)
    case movieDetail(id: Int)
    case searchMovie(name: String)
    case discovering(year: String)
    case trendings
    case genre
}

extension MoviesEndpoint: EndPoint {
    
    var host: String {
        return "api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .topRated(_) :
            return "/3/movie/top_rated"
        case .movieDetail(let id):
            return "/3/movie/\(id)"
        case .searchMovie(_):
            return "/3/search/movie"
        case .genre:
            return "/3/genre/movie/list"
        case .discovering(_):
            return "/3/discover/movie"
        case .trendings:
            return "/3/trending/movie/day"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .topRated, .movieDetail, .searchMovie, .genre, .discovering, .trendings:
            return .get
        }
    }
    
    var header: [String : String]? {
        let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhNjllZDNkMDEzYTliYTg0NzNlZWVmZDAwMTg4OWUxYSIsInN1YiI6IjVmMjIyNjMzY2FhY2EyMDAzNDY4MjcwNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.FoUTRlT41OXn1uhnfTbOOfY3vOOXSMobSR2cY60ixp8"
        switch self {
        case .topRated, .movieDetail, .searchMovie, .genre, .discovering, .trendings:
            return [
                "Authorization": "Bearer \(accessToken)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .topRated, .movieDetail, .searchMovie, .genre, .discovering, .trendings:
            return nil
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case.topRated(let page): return [.init(name: "page", value: "\(page)")]
        case .movieDetail: return nil
        case .searchMovie(let name): return [.init(name: "query", value: "\(name)")]
        case .genre: return nil
        case .discovering(let year): return [.init(name: "year", value: "\(year)")]
        case .trendings: return nil
        }
    }
}
