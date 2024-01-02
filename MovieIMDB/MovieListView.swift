//
//  MovieListView.swift
//  MovieIMDB
//
//  Created by Thiago M Faria on 05/12/23.
//

import SwiftUI

private class DebouncedState<Value>: ObservableObject {
    @Published var currentValue: Value
    @Published var debouncedValue: Value
    
    init(initialValue: Value, delay: Double = 1) {
        _currentValue = Published(initialValue: initialValue)
        _debouncedValue = Published(initialValue: initialValue)
        $currentValue
            .debounce(for: .seconds(delay), scheduler: RunLoop.main)
            .assign(to: &$debouncedValue)
    }
}

struct MovieListView: View {
    
    @EnvironmentObject private var model: MovieModel
    
    @StateObject private var searchTerm = DebouncedState(initialValue: "")
    
    var body: some View {
        NavigationStack {
            if model.searchIsActive {
                SearchedMovies()
            } else {
                TopRated()
            }
        }.navigationTitle("WannaSee")
        .searchable(text: $searchTerm.currentValue, placement: .automatic, prompt: "I wanna see...")
        .onChange(of: searchTerm.debouncedValue) { oldState, newState in
            print(newState)
            model.callSearchingMovie(movieText: newState)
        }
    }
}

#Preview {
    MovieListView().environmentObject(MovieModel(movieService: MoviesService()))
}
