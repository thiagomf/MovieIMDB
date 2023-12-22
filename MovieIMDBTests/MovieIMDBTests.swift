//
//  MovieIMDBTests.swift
//  MovieIMDBTests
//
//  Created by Thiago M Faria on 30/11/23.
//

import XCTest
import NetworkLayer

@testable import MovieIMDB

final class MovieIMDBTests: XCTestCase {

    func testMoviesServiceMock() async {
        let serviceMock = MoviesServiceMock()
        let response = await serviceMock.getMovieDetail(id: 0)
        
        switch response {
        case .success(let movie): XCTAssertEqual(movie.originalTitle, "The Godfather")
        case .failure(_): XCTFail("The request should not fail")
        }
    }
    
    func testLoadTopRatedMovies() async {
        let serviceMock = MoviesServiceMock()
        let response = await serviceMock.getTopRated(page: 0)
        
        switch response {
        case .success(let topRated): XCTAssertNotEqual(topRated.results.count, 0)
        case .failure(_): XCTFail("The request should not fail")
        }
    }

}

final class MoviesServiceMock: Mockable, MoviesServiceable {
    
    func getTopRated(page: Int) async -> Result<MovieIMDB.MovieResult, RequestError> {
        return .success(loadJSON(filename: "TopRatedResponse", type: MovieResult.self))
    }
    
    func getMovieDetail(id: Int) async -> Result<MovieIMDB.SelectedMovie, RequestError> {
        return .success(loadJSON(filename: "MovieSelectedResponse", type: SelectedMovie.self))
    }
    
    
}
