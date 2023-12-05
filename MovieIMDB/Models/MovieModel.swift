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
    @Published var movie : Movie? = nil
    
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
            print("Erro to get all movies: \(error)")
        }
    }
    
    func getIDMovie(id: Int) async {
        let result = await movieService.getMovieDetail(id: id)
        switch result {
        case .success(let response):
            self.movie = response
        case .failure(let error):
            print("Erro to get \(id) Movie: \(error)")
        }
    }
}
