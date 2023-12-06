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
        let response = await serviceMock.getTopRated()
        
        switch response {
        case .success(let topRated): XCTAssertNotEqual(topRated.results.count, 0)
        case .failure(_): XCTFail("The request should not fail")
        }
    }

}

final class MoviesServiceMock: Mockable, MoviesServiceable {
    
    func getTopRated() async -> Result<MovieIMDB.TopRated, RequestError> {
        return .success(loadJSON(filename: "TopRatedResponse", type: TopRated.self))
    }
    
    func getMovieDetail(id: Int) async -> Result<MovieIMDB.SelectedMovie, RequestError> {
        return .success(loadJSON(filename: "MovieSelectedResponse", type: SelectedMovie.self))
    }
    
    
}
