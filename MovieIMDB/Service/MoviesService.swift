//
//  MoviesService.swift
//  MovieIMDB
//
//  Created by Thiago M Faria on 01/12/23.
//

import Foundation
import NetworkLayer

protocol MoviesServiceable {
    func getTopRated(page: Int) async -> Result <TopRated, RequestError>
    func getMovieDetail(id: Int) async -> Result <SelectedMovie, RequestError>
}

struct MoviesService: MoviesServiceable {

    func getTopRated(page: Int = 1) async -> Result<TopRated, RequestError> {
        return await NetworkLayer().sendRequest(endPoint: MoviesEndpoint.topRated(page: page),
                                 responseModel: TopRated.self)
    }
    
    func getMovieDetail(id: Int) async -> Result<SelectedMovie, RequestError> {
        return await NetworkLayer().sendRequest(endPoint: MoviesEndpoint.movieDetail(id: id),
                                                responseModel: SelectedMovie.self)
    }
}
