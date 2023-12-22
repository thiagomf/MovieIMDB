//
//  SearchedMovies.swift
//  MovieIMDB
//
//  Created by Thiago M Faria on 19/12/23.
//

import SwiftUI

struct SearchedMovies: View {
    
    @EnvironmentObject private var model: MovieModel
    @State private var clickAction: Actions?
    
    var body: some View {
        ScrollView {
            ForEach(model.searchedMovie) { movie in
                LazyVStack {
                    MovieCardUIView(movie: movie).padding(5)
                }.onTapGesture {
                    clickAction = .goToView(movie)
                }
            }
        }.overlay(content: {
            if model.movies.isEmpty {
                ProgressView("Carregando...").frame(width: 250)
            }
        }).sheet(item: $clickAction, onDismiss: {
            
            model.selected = nil
            
        }, content: { click in
            switch click {
            case .goToView(let movie):
                MovieView(movieSelected: movie)
            }
        })
    }
}

#Preview {
    SearchedMovies()
}
