//
//  MovieModel.swift
//  MovieIMDB
//
//  Created by Thiago M Faria on 05/12/23.
//
import UIKit
import SwiftUI
import NetworkLayer

@MainActor
class MovieModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var movie : SelectedMovie? = nil
    @Published var errorServer: RequestError?
    
    let movieService: MoviesService
    
    init(movieService: MoviesService) {
        self.movieService = movieService
    }

    func getAllMovies() async {
        let result = await movieService.getTopRated()
        switch result {
        case .success(let response):
            self.movies = response.results
        case .failure(let error):
            self.errorServer = error
        }
    }
    
    func getIDMovie(id: Int) async {
        let result = await movieService.getMovieDetail(id: id)
        switch result {
        case .success(let response):
            self.movie = response
        case .failure(let error):
            self.errorServer = error
        }
    }
}
