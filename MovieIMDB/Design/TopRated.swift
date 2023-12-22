//
//  TopRated.swift
//  MovieIMDB
//
//  Created by Thiago M Faria on 19/12/23.
//

import SwiftUI

enum Actions: Identifiable {
    
    case goToView(Movie)
    
    var id: Int {
        switch self {
        case .goToView(_):
            return 1
        }
    }
}

struct TopRated: View {
    
    @EnvironmentObject private var model: MovieModel
    @State private var clickAction: Actions?
    
    var body: some View {
        
        ScrollView {
            ForEach(model.movies) { movie in
                LazyVStack {
                    MovieCardUIView(movie: movie).padding(5).onAppear {
                        model.getTopRated(movie)
                    }
                }.onTapGesture {
                    clickAction = .goToView(movie)
                }
            }
        }
        .overlay(content: {
            if model.movies.isEmpty {
                ProgressView("Carregando...").frame(width: 250)
            }
        })
        .sheet(item: $clickAction, onDismiss: {
            
            model.selected = nil
            
        }, content: { click in
            switch click {
            case .goToView(let movie):
                MovieView(movieSelected: movie)
            }
        }).task {
            await model.getBestMovies(page: 1)
        }
    }
}

#Preview {
    TopRated().environmentObject(MovieModel(movieService: MoviesService()))
}
