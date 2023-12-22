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
    
    @Published var searchIsActive: Bool = false
    @Published var searchedMovie: [Movie] = []
    
    @Published var selected : SelectedMovie? = nil
    @Published var errorServer: RequestError?
    
    var pageId = 1

    enum PagingState {
        case loading
        case loadingNextPage
    }
    
    let movieService: MoviesService
    var state: PagingState = .loading
    
    init(movieService: MoviesService) {
        self.movieService = movieService
    }
    
    func getTopRated(_ movie: Movie) {

        guard let index = movies.firstIndex(where: { $0.id == movie.id }) else {
            return
        }
        
        let thresholdIndex = movies.index(movies.endIndex, offsetBy: -4)
        
        if index != thresholdIndex {
            return
        }
        
        switch state {
        case .loading:
              return
        case .loadingNextPage:
            self.pageId += 1
        }
        
        Task {
            await getBestMovies(page: pageId)
        }
    }
    
    func callSearchingMovie(movieText: String) {
        
        searchIsActive = true
        
        if !movieText.isEmpty {
            Task {
                await getSearchMovie(name: movieText)
            }
        } else {
            searchIsActive = false
        }
        
    }

    func getBestMovies(page: Int) async {
        self.state = .loading
        let result = await movieService.getTopRated(page: page)
        switch result {
        case .success(let response):
            self.movies += response.results
        case .failure(let error):
            self.errorServer = error
            self.pageId -= 1
        }
        self.state = .loadingNextPage
    }
    
    func getIDMovie(id: Int) async {
        let result = await movieService.getMovieDetail(id: id)
        switch result {
        case .success(let response):
            self.selected = response
        case .failure(let error):
            self.errorServer = error
        }
    }
    
    func getSearchMovie(name: String) async {
        let result = await movieService.getSearchMovie(name: name)
        switch result {
        case .success(let response):
            self.searchedMovie = response.results
        case .failure(let error):
            self.errorServer = error
        }
    }
}
