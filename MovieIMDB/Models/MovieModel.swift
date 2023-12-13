//
//  MovieModel.swift
//  MovieIMDB
//
//  Created by Thiago M Faria on 05/12/23.
//
import UIKit
import SwiftUI
import NetworkLayer

private var currentTask: Task<Void, Never>? {
    willSet {
        if let task = currentTask {
            if task.isCancelled { return }
            task.cancel()
            // Setting a new task cancelling the current task
        }
    }
}

@MainActor
class MovieModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var selected : SelectedMovie? = nil
    @Published var errorServer: RequestError?
    
    var pageId = 0
    
    enum PagingState {
        case loadingFirstPage
        case loaded
        case loadingNextPage
        case error(error: Error)
    }
    
    let movieService: MoviesService
    var state: PagingState = .loaded
    
    
    init(movieService: MoviesService) {
        self.movieService = movieService
    }
    
    func onItemAppear() {
        
        self.pageId += 1

        state = .loadingNextPage
            currentTask = Task {
                await getBestMovies(page: pageId)
        }
        
    }

    func getBestMovies(page: Int) async {
        let result = await movieService.getTopRated(page: page)
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
            self.selected = response
        case .failure(let error):
            self.errorServer = error
        }
    }
}
