//
//  MoviesService.swift
//  MovieIMDB
//
//  Created by Thiago M Faria on 01/12/23.
//

import Foundation
import NetworkLayer

protocol MoviesServiceable {
    func getTopRated(page: Int) async -> Result <MovieResult, RequestError>
    func getMovieDetail(id: Int) async -> Result <SelectedMovie, RequestError>
    func getSearchMovie(name: String) async -> Result <MovieResult, RequestError>
    func getGenre() async -> Result<GenreList, RequestError>
    func getTrendings() async -> Result<MovieResult, RequestError>
}

struct MoviesService: MoviesServiceable {

    func getTopRated(page: Int = 1) async -> Result<MovieResult, RequestError> {
        return await NetworkLayer().sendRequest(endPoint: MoviesEndpoint.topRated(page: page),
                                 responseModel: MovieResult.self)
    }
    
    func getMovieDetail(id: Int) async -> Result<SelectedMovie, RequestError> {
        return await NetworkLayer().sendRequest(endPoint: MoviesEndpoint.movieDetail(id: id),
                                                responseModel: SelectedMovie.self)
    }
    
    func getSearchMovie(name: String) async -> Result<MovieResult, RequestError> {
        return await NetworkLayer().sendRequest(endPoint: MoviesEndpoint.searchMovie(name: name),
                                                responseModel: MovieResult.self)
    }
    
    func getDiscovering(year: String) async -> Result<MovieResult, RequestError> {
        return await NetworkLayer().sendRequest(endPoint: MoviesEndpoint.discovering(year: year),
                                                responseModel: MovieResult.self)
    }
    
    func getGenre() async -> Result<GenreList, RequestError> {
        return await NetworkLayer().sendRequest(endPoint: MoviesEndpoint.genre,
                                                responseModel: GenreList.self)
    }
    
    func getTrendings() async -> Result<MovieResult, RequestError> {
        return await NetworkLayer().sendRequest(endPoint: MoviesEndpoint.trendings,
                                                responseModel: MovieResult.self)
    }
}
